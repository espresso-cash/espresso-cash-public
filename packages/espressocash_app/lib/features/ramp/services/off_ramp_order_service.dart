import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../config.dart';
import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token_list.dart';
import '../../../data/db/db.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../authenticated/auth_scope.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../kado/data/kado_api_client.dart';

@Singleton(scope: authScope)
class OffRampOrderService implements Disposable {
  OffRampOrderService(
    this._account,
    this._client,
    this._sender,
    this._db,
    this._tokens,
    this._kadoApi,
  );

  final ECWallet _account;
  final CryptopleaseClient _client;
  final TxSender _sender;
  final MyDatabase _db;
  final TokenList _tokens;
  final KadoApiClient _kadoApi;

  bool _isDisposed = false;
  final Map<String, Future<void>> _processing = {};

  @PostConstruct()
  Future<void> init() async {
    final query = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) => tbl.status.equalsValue(OffRampOrderStatus.completed).not(),
      );

    final orders = await query.get();

    for (final order in orders) {
      unawaited(_add(order.id));
    }
  }

  Stream<IList<({String id, DateTime created})>> watchPending() {
    final query = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) => tbl.status.equalsValue(OffRampOrderStatus.completed).not(),
      );

    return query
        .watch()
        .map((rows) => rows.map((r) => (id: r.id, created: r.created)))
        .map((rows) => rows.toIList());
  }

  @useResult
  AsyncResult<void> create({
    required String partnerOrderId,
    required CryptoAmount amount,
  }) =>
      tryEitherAsync((_) async {
        {
          final partnerOrder = await _kadoApi.getOrderStatus(partnerOrderId);
          final depositAddress = partnerOrder.data?.depositAddress;

          if (depositAddress == null) {
            throw Exception('No deposit address');
          }

          final order = OffRampOrderRow(
            id: const Uuid().v4(),
            amount: amount.value,
            token: amount.token.address,
            created: DateTime.now(),
            humanStatus: '',
            machineStatus: '',
            partnerOrderId: partnerOrderId,
            transaction: '',
            slot: BigInt.zero,
            status: OffRampOrderStatus.makingDeposit,
            depositAddress: depositAddress,
          );

          await _db.into(_db.offRampOrderRows).insert(order);
          unawaited(_add(order.id));
        }
      });

  Future<void> _add(String orderId) async {
    while (!_isDisposed) {
      final result = await _process(orderId, processDepositError: false);

      if (result) {
        unawaited(_processing.remove(orderId));

        return;
      }

      await Future<void>.delayed(const Duration(seconds: 5));
    }
  }

  Future<bool> _process(
    String orderId, {
    required bool processDepositError,
  }) async {
    Expression<bool> where($OffRampOrderRowsTable tbl) =>
        tbl.id.equals(orderId);
    final updateQuery = _db.update(_db.offRampOrderRows)..where(where);
    final selectQuery = _db.select(_db.offRampOrderRows)..where(where);

    Future<bool> writeDepositError() async {
      if (_isDisposed) return true;

      return updateQuery
          .write(const _C(status: Value(OffRampOrderStatus.depositError)))
          .then(F);
    }

    final order = await selectQuery.getSingle();

    // If the order is already completed, we don't need to do anything else.
    if (order.status == OffRampOrderStatus.completed) return true;

    if (order.status == OffRampOrderStatus.makingDeposit ||
        order.status == OffRampOrderStatus.depositError &&
            processDepositError) {
      final (SignedTx, BigInt) tx;

      // Retrieve tx from saved order or create if it was not created before (or
      // was deleted).
      if (order.transaction.isEmpty) {
        final created = await _createTx(
          amount: _amount(order),
          receiver: Ed25519HDPublicKey.fromBase58(order.depositAddress),
        );

        if (created == null) return writeDepositError();

        tx = created;

        if (_isDisposed) return true;

        await updateQuery.write(
          _C(
            // Reset status to makingDeposit since it could be depositError.
            status: const Value(OffRampOrderStatus.makingDeposit),
            transaction: Value(tx.$1.encode()),
            slot: Value(tx.$2),
          ),
        );
      } else {
        tx = SignedTx.decode(order.transaction).let((it) => (it, order.slot));
      }

      final sent = await _sender.send(tx.$1, minContextSlot: tx.$2);
      switch (sent) {
        case TxSendSent():
          break;
        case TxSendInvalidBlockhash():
        case TxSendFailure():
          if (_isDisposed) return true;

          await updateQuery.write(
            _C(
              status: const Value(OffRampOrderStatus.depositError),
              transaction: const Value(''),
              slot: Value(BigInt.zero),
            ),
          );

          return true;
        case TxSendNetworkError():
          return writeDepositError();
      }

      final confirmed = await _sender.wait(tx.$1, minContextSlot: tx.$2);
      switch (confirmed) {
        case TxWaitSuccess():
          if (_isDisposed) return true;

          await updateQuery.write(
            const _C(status: Value(OffRampOrderStatus.waitingForPartner)),
          );
        case TxWaitFailure():
          if (_isDisposed) return true;

          await updateQuery.write(
            _C(
              status: const Value(OffRampOrderStatus.depositError),
              transaction: const Value(''),
              slot: Value(BigInt.zero),
            ),
          );

          return false;
        case TxWaitNetworkError():
          return writeDepositError();
      }
    }

    final partnerOrder =
        await _kadoApi.getOrderStatus(order.partnerOrderId).toEither();
    switch (partnerOrder) {
      case Left<Exception, OrderStatusResponseDto>():
        return false;
      case Right<Exception, OrderStatusResponseDto>(:final value):
        if (_isDisposed) return true;

        await updateQuery.write(
          _C(
            machineStatus: Value(value.data?.machineStatusField.name ?? ''),
            humanStatus: Value(value.data?.humanStatusField ?? ''),
            status: value.data?.machineStatusField == MachineStatus.settled
                ? const Value(OffRampOrderStatus.completed)
                : const Value(OffRampOrderStatus.waitingForPartner),
          ),
        );

        return value.data?.machineStatusField == MachineStatus.settled;
    }
  }

  @override
  Future<void> onDispose() {
    _isDisposed = true;

    return _db.delete(_db.offRampOrderRows).go();
  }

  CryptoAmount _amount(OffRampOrderRow order) => CryptoAmount(
        value: order.amount,
        cryptoCurrency: CryptoCurrency(
          token: _tokens.requireTokenByMint(order.token),
        ),
      );

  Future<(SignedTx, BigInt)?> _createTx({
    required CryptoAmount amount,
    required Ed25519HDPublicKey receiver,
  }) async {
    try {
      final dto = CreateDirectPaymentRequestDto(
        senderAccount: _account.address,
        receiverAccount: receiver.toBase58(),
        amount: amount.value,
        referenceAccount: null,
        cluster: apiCluster,
      );
      final response = await _client.createDirectPayment(dto);
      final tx = await response
          .let((it) => it.transaction)
          .let(SignedTx.decode)
          .let((it) => it.resign(_account));

      return (tx, response.slot);
    } on Exception {
      return null;
    }
  }
}

typedef _C = OffRampOrderRowsCompanion;

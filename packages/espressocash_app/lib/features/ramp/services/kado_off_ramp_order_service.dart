import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
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

typedef OffRampOrder = ({
  String id,
  DateTime created,
  OffRampOrderStatus status,
  CryptoAmount amount,
});

@Singleton(scope: authScope)
class KadoOffRampOrderService implements Disposable {
  KadoOffRampOrderService(
    this._account,
    this._client,
    this._sender,
    this._db,
    this._tokens,
    this._kadoApi,
  );

  final Map<String, StreamSubscription<void>> _subscriptions = {};

  final ECWallet _account;
  final CryptopleaseClient _client;
  final TxSender _sender;
  final MyDatabase _db;
  final TokenList _tokens;
  final KadoApiClient _kadoApi;

  @PostConstruct()
  Future<void> init() async {
    final query = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) => tbl.status.equalsValue(OffRampOrderStatus.completed).not(),
      );

    final orders = await query.get();

    for (final order in orders) {
      _subscribe(order.id);
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

  Stream<OffRampOrder> watch(String orderId) {
    final query = _db.select(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));

    return query.watchSingle().map((row) {
      final amount = CryptoAmount(
        value: row.amount,
        cryptoCurrency: CryptoCurrency(
          token: _tokens.requireTokenByMint(row.token),
        ),
      );

      return (
        id: row.id,
        created: row.created,
        status: row.status,
        amount: amount,
      );
    });
  }

  Future<void> retry(String orderId) async {
    final query = _db.select(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));
    final order = await query.getSingle();

    final updateQuery = _db.update(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));

    switch (order.status) {
      case OffRampOrderStatus.depositTxRequired:
        await updateQuery.write(
          const OffRampOrderRowsCompanion(
            status: Value(OffRampOrderStatus.creatingDepositTx),
          ),
        );
      case OffRampOrderStatus.depositError:
        final tx = order.transaction;
        if (tx.isEmpty) {
          await updateQuery.write(
            const OffRampOrderRowsCompanion(
              status: Value(OffRampOrderStatus.creatingDepositTx),
            ),
          );
        } else {
          await updateQuery.write(
            const OffRampOrderRowsCompanion(
              status: Value(OffRampOrderStatus.sendingDepositTx),
            ),
          );
        }
      case OffRampOrderStatus.creatingDepositTx:
      case OffRampOrderStatus.depositTxReady:
      case OffRampOrderStatus.sendingDepositTx:
      case OffRampOrderStatus.waitingForPartner:
      case OffRampOrderStatus.failure:
      case OffRampOrderStatus.completed:
        break;
    }
  }

  @useResult
  AsyncResult<String> create({
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
            status: OffRampOrderStatus.depositTxRequired,
            depositAddress: depositAddress,
          );

          await _db.into(_db.offRampOrderRows).insert(order);
          _subscribe(order.id);

          return order.id;
        }
      });

  void _subscribe(String orderId) {
    _subscriptions[orderId] = (_db.select(_db.offRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingle()
        .asyncExpand<OffRampOrderRowsCompanion>((order) {
      switch (order.status) {
        case OffRampOrderStatus.depositTxRequired:
        case OffRampOrderStatus.depositError:
          return const Stream.empty();
        case OffRampOrderStatus.creatingDepositTx:
          return Stream.fromFuture(
            _createTx(
              amount: _amount(order),
              receiver: Ed25519HDPublicKey.fromBase58(order.depositAddress),
            ),
          ).onErrorReturn(
            const OffRampOrderRowsCompanion(
              status: Value(OffRampOrderStatus.depositError),
            ),
          );
        case OffRampOrderStatus.sendingDepositTx:
          final tx =
              SignedTx.decode(order.transaction).let((it) => (it, order.slot));

          return Stream.fromFuture(_sendTx(tx));
        case OffRampOrderStatus.depositTxReady:
          return Stream.value(
            const OffRampOrderRowsCompanion(
              status: Value(OffRampOrderStatus.sendingDepositTx),
            ),
          );
        case OffRampOrderStatus.waitingForPartner:
          return Stream<void>.periodic(const Duration(seconds: 10))
              .asyncMap((_) => _checkPartnerStatus(order.partnerOrderId));
        case OffRampOrderStatus.failure:
        case OffRampOrderStatus.completed:
          _subscriptions[orderId]?.cancel();
          _subscriptions.remove(orderId);

          return const Stream.empty();
      }
    }).listen(
      (event) => (_db.update(_db.offRampOrderRows)
            ..where((tbl) => tbl.id.equals(orderId)))
          .write(event),
    );
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    await _db.delete(_db.offRampOrderRows).go();
  }

  CryptoAmount _amount(OffRampOrderRow order) => CryptoAmount(
        value: order.amount,
        cryptoCurrency: CryptoCurrency(
          token: _tokens.requireTokenByMint(order.token),
        ),
      );

  Future<OffRampOrderRowsCompanion> _createTx({
    required CryptoAmount amount,
    required Ed25519HDPublicKey receiver,
  }) async {
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

    return OffRampOrderRowsCompanion(
      status: const Value(OffRampOrderStatus.depositTxReady),
      transaction: Value(tx.encode()),
      slot: Value(response.slot),
    );
  }

  Future<OffRampOrderRowsCompanion> _sendTx((SignedTx, BigInt) tx) async {
    final sent = await _sender.send(tx.$1, minContextSlot: tx.$2);
    switch (sent) {
      case TxSendSent():
        break;
      case TxSendInvalidBlockhash():
      case TxSendFailure():
        return OffRampOrderRowsCompanion(
          status: const Value(OffRampOrderStatus.depositError),
          transaction: const Value(''),
          slot: Value(BigInt.zero),
        );
      case TxSendNetworkError():
        return _depositError;
    }

    final confirmed = await _sender.wait(tx.$1, minContextSlot: tx.$2);
    switch (confirmed) {
      case TxWaitSuccess():
        return const OffRampOrderRowsCompanion(
          status: Value(OffRampOrderStatus.waitingForPartner),
        );
      case TxWaitFailure():
        return OffRampOrderRowsCompanion(
          status: const Value(OffRampOrderStatus.depositError),
          transaction: const Value(''),
          slot: Value(BigInt.zero),
        );
      case TxWaitNetworkError():
        return _depositError;
    }
  }

  Future<OffRampOrderRowsCompanion> _checkPartnerStatus(String orderId) async {
    final partnerOrder = await _kadoApi.getOrderStatus(orderId);

    return OffRampOrderRowsCompanion(
      machineStatus: Value(partnerOrder.data?.machineStatusField.name ?? ''),
      humanStatus: Value(partnerOrder.data?.humanStatusField ?? ''),
      status: partnerOrder.data?.machineStatusField == MachineStatus.settled
          ? const Value(OffRampOrderStatus.completed)
          : const Value(OffRampOrderStatus.waitingForPartner),
    );
  }

  static const _depositError =
      OffRampOrderRowsCompanion(status: Value(OffRampOrderStatus.depositError));
}

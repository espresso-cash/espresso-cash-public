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
import '../../../data/db/db.dart';
import '../../../di.dart';
import '../../accounts/auth_scope.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../../tokens/token_list.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/resign_tx.dart';
import '../../transactions/services/tx_sender.dart';
import '../models/ramp_watcher.dart';
import '../partners/coinflow/services/coinflow_off_ramp_order_watcher.dart';
import '../partners/kado/services/kado_off_ramp_order_watcher.dart';
import '../partners/scalex/services/scalex_off_ramp_order_watcher.dart';

typedef OffRampOrder = ({
  String id,
  DateTime created,
  OffRampOrderStatus status,
  CryptoAmount amount,
  CryptoAmount? fee,
  RampPartner partner,
  DateTime? resolved,
  FiatAmount? receiveAmount,
  String partnerOrderId,
  Ed25519HDPublicKey? depositAddress,
  String? moreInfoUrl,
  String? withdrawAnchorAccount,
  String? withdrawUrl,
  String? authToken,
  String? referenceNumber,
  CryptoAmount? bridgeAmount,
});

@Singleton(scope: authScope)
class OffRampOrderService implements Disposable {
  OffRampOrderService(
    this._account,
    this._client,
    this._sender,
    this._db,
    this._tokens,
  );

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, RampWatcher?> _watchers = {};

  final ECWallet _account;
  final EspressoCashClient _client;
  final TxSender _sender;
  final MyDatabase _db;
  final TokenList _tokens;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final query = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) => tbl.status.isNotInValues([
          OffRampOrderStatus.completed,
          OffRampOrderStatus.cancelled,
        ]),
      );

    final orders = await query.get();

    for (final order in orders) {
      if (order.partner == RampPartner.moneygram) {
        continue;
      }

      _subscribe(order.id);
      unawaited(_watch(order.id));
    }
  }

  Stream<IList<({String id, DateTime created})>> watchPending() {
    final query = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) => tbl.status.equalsValue(OffRampOrderStatus.completed).not(),
      )
      ..where(
        (tbl) => tbl.status.equalsValue(OffRampOrderStatus.cancelled).not(),
      )
      ..where(
        (tbl) => tbl.status.equalsValue(OffRampOrderStatus.refunded).not(),
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

      final fee = row.feeAmount?.let(
        (amount) {
          final token = row.feeToken;

          if (token == null) return null;

          return CryptoAmount(
            value: amount,
            cryptoCurrency: CryptoCurrency(
              token: _tokens.requireTokenByMint(token),
            ),
          );
        },
      );

      final receiveAmount = row.receiveAmount?.let(
        (it) => Amount(
          value: it,
          currency: currencyFromString(row.fiatSymbol ?? 'USD'),
        ) as FiatAmount,
      );

      final bridgeAmount = row.bridgeAmount?.let(
        (it) => Amount(
          value: it,
          currency: Currency.usdc,
        ) as CryptoAmount,
      );

      final depositAddress = row.depositAddress
          .maybeWhere((it) => it.isNotEmpty)
          ?.let(Ed25519HDPublicKey.fromBase58);

      return (
        id: row.id,
        created: row.created,
        status: row.status,
        amount: amount,
        partner: row.partner,
        resolved: row.resolvedAt,
        receiveAmount: receiveAmount,
        partnerOrderId: row.partnerOrderId,
        depositAddress: depositAddress,
        withdrawAnchorAccount: row.withdrawAnchorAccount,
        moreInfoUrl: row.moreInfoUrl,
        fee: fee,
        withdrawUrl: row.withdrawUrl,
        authToken: row.authToken,
        referenceNumber: row.referenceNumber,
        bridgeAmount: bridgeAmount,
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
      case OffRampOrderStatus.depositTxConfirmError:
      case OffRampOrderStatus.insufficientFunds:
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
      case OffRampOrderStatus.preProcessing:
      case OffRampOrderStatus.postProcessing:
      case OffRampOrderStatus.ready:
      case OffRampOrderStatus.sendingDepositTx:
      case OffRampOrderStatus.waitingForPartner:
      case OffRampOrderStatus.failure:
      case OffRampOrderStatus.processingRefund:
      case OffRampOrderStatus.waitingForRefundBridge:
      case OffRampOrderStatus.refunded:
      case OffRampOrderStatus.completed:
      case OffRampOrderStatus.cancelled:
        break;
    }
  }

  Future<void> cancel(String orderId) async {
    final query = _db.select(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));
    final order = await query.getSingle();

    final updateQuery = _db.update(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));

    switch (order.status) {
      case OffRampOrderStatus.depositError:
      case OffRampOrderStatus.insufficientFunds:
        await updateQuery.write(_cancelled);
      case OffRampOrderStatus.ready:
        if (order.partner == RampPartner.moneygram) {
          await updateQuery.write(_processRefund);
        }
      case OffRampOrderStatus.depositTxRequired:
      case OffRampOrderStatus.creatingDepositTx:
      case OffRampOrderStatus.depositTxReady:
      case OffRampOrderStatus.sendingDepositTx:
      case OffRampOrderStatus.waitingForPartner:
      case OffRampOrderStatus.failure:
      case OffRampOrderStatus.processingRefund:
      case OffRampOrderStatus.waitingForRefundBridge:
      case OffRampOrderStatus.completed:
      case OffRampOrderStatus.cancelled:
      case OffRampOrderStatus.depositTxConfirmError:
      case OffRampOrderStatus.preProcessing:
      case OffRampOrderStatus.postProcessing:
      case OffRampOrderStatus.refunded:
        break;
    }
  }

  @useResult
  AsyncResult<String> create({
    required String partnerOrderId,
    required CryptoAmount amount,
    required RampPartner partner,
    required String depositAddress,
    (SignedTx, BigInt)? transaction,
    FiatAmount? receiveAmount,
    CryptoAmount? fee,
  }) =>
      tryEitherAsync((_) async {
        {
          final order = OffRampOrderRow(
            id: const Uuid().v4(),
            amount: amount.value,
            token: amount.token.address,
            created: DateTime.now(),
            humanStatus: '',
            machineStatus: '',
            partnerOrderId: partnerOrderId,
            transaction: transaction?.$1.encode() ?? '',
            slot: transaction?.$2 ?? BigInt.zero,
            status: transaction == null
                ? OffRampOrderStatus.depositTxRequired
                : OffRampOrderStatus.depositTxReady,
            depositAddress: depositAddress,
            partner: partner,
            receiveAmount: receiveAmount?.value,
            fiatSymbol: receiveAmount?.currency.symbol,
            feeAmount: fee?.value,
            feeToken: fee?.token.address,
          );

          await _db.into(_db.offRampOrderRows).insert(order);
          _subscribe(order.id);
          await _watch(order.id);

          return order.id;
        }
      });

  @useResult
  AsyncResult<String> createFromTx({
    required SignedTx tx,
    required CryptoAmount amount,
    required RampPartner partner,
    required BigInt slot,
    FiatAmount? receiveAmount,
  }) =>
      tryEitherAsync((bind) async {
        {
          final signed = await tx.let((it) => it.resign(_account));

          return create(
            partnerOrderId: signed.id,
            amount: amount,
            partner: partner,
            depositAddress: '',
            receiveAmount: receiveAmount,
            transaction: (signed, slot),
          ).letAsync(bind);
        }
      });

  Future<void> _watch(String orderId) async {
    final query = _db.select(_db.offRampOrderRows)
      ..where((tbl) => tbl.id.equals(orderId));

    final order = await query.getSingle();

    _watchers[orderId] = switch (order.partner) {
      RampPartner.kado => sl<KadoOffRampOrderWatcher>(),
      RampPartner.scalex => sl<ScalexOffRampOrderWatcher>(),
      RampPartner.coinflow => sl<CoinflowOffRampOrderWatcher>(),
      RampPartner.rampNetwork ||
      RampPartner.moneygram || // moneygram orders will not reach this point
      RampPartner.guardarian =>
        throw ArgumentError('Not implemented'),
    }
      ..watch(orderId);
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = (_db.select(_db.offRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingle()
        .asyncExpand<OffRampOrderRowsCompanion>((order) {
      switch (order.status) {
        case OffRampOrderStatus.depositTxRequired:
        case OffRampOrderStatus.depositError:
        case OffRampOrderStatus.depositTxConfirmError:
        case OffRampOrderStatus.preProcessing:
        case OffRampOrderStatus.postProcessing:
        case OffRampOrderStatus.ready:
        case OffRampOrderStatus.insufficientFunds:
        case OffRampOrderStatus.waitingForPartner:
          return const Stream.empty();
        case OffRampOrderStatus.creatingDepositTx:
          return Stream.fromFuture(
            order.partner == RampPartner.scalex
                ? _createScalexTx(
                    partnerOrderId: order.partnerOrderId,
                  )
                : _createTx(
                    amount: _amount(order),
                    receiver: Ed25519HDPublicKey.fromBase58(
                      order.depositAddress,
                    ),
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
        case OffRampOrderStatus.cancelled:
        case OffRampOrderStatus.failure:
        case OffRampOrderStatus.processingRefund:
        case OffRampOrderStatus.waitingForRefundBridge:
        case OffRampOrderStatus.refunded:
        case OffRampOrderStatus.completed:
          _subscriptions.remove(orderId)?.cancel();

          _watchers[orderId]?.close();
          _watchers.remove(orderId);

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
    _watchers.values.map((it) => it?.close());
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

    return _signAndUpdateRow(
      encodedTx: response.transaction,
      slot: response.slot,
    );
  }

  Future<OffRampOrderRowsCompanion> _createScalexTx({
    required String partnerOrderId,
  }) async {
    final dto = ScalexWithdrawRequestDto(
      orderId: partnerOrderId,
      cluster: apiCluster,
    );
    final response = await _client.createScalexWithdraw(dto);

    return _signAndUpdateRow(
      encodedTx: response.transaction,
      slot: response.slot,
    );
  }

  Future<OffRampOrderRowsCompanion> _signAndUpdateRow({
    required String encodedTx,
    required BigInt slot,
  }) async {
    final tx =
        await SignedTx.decode(encodedTx).let((it) => it.resign(_account));

    return OffRampOrderRowsCompanion(
      status: const Value(OffRampOrderStatus.depositTxReady),
      transaction: Value(tx.encode()),
      slot: Value(slot),
    );
  }

  Future<OffRampOrderRowsCompanion> _sendTx((SignedTx, BigInt) tx) async {
    final sent = await _sender.send(tx.$1, minContextSlot: tx.$2);
    switch (sent) {
      case TxSendSent():
        break;
      case TxSendInvalidBlockhash():
        return OffRampOrderRowsCompanion(
          status: const Value(OffRampOrderStatus.depositError),
          transaction: const Value(''),
          slot: Value(BigInt.zero),
        );
      case TxSendFailure(:final reason):
        return OffRampOrderRowsCompanion(
          status: reason == TxFailureReason.insufficientFunds
              ? const Value(OffRampOrderStatus.insufficientFunds)
              : const Value(OffRampOrderStatus.depositError),
          transaction: const Value(''),
          slot: Value(BigInt.zero),
        );
      case TxSendNetworkError():
        return _depositError;
    }

    final confirmed = await _sender.wait(
      tx.$1,
      minContextSlot: tx.$2,
      txType: 'OffRamp',
    );
    switch (confirmed) {
      case TxWaitSuccess():
        return const OffRampOrderRowsCompanion(
          status: Value(OffRampOrderStatus.waitingForPartner),
        );
      case TxWaitFailure(:final reason):
        return OffRampOrderRowsCompanion(
          status: reason == TxFailureReason.insufficientFunds
              ? const Value(OffRampOrderStatus.insufficientFunds)
              : const Value(OffRampOrderStatus.depositTxConfirmError),
          transaction: const Value(''),
          slot: Value(BigInt.zero),
        );
      case TxWaitNetworkError():
        return _depositError;
    }
  }

  static final _cancelled = OffRampOrderRowsCompanion(
    status: const Value(OffRampOrderStatus.cancelled),
    resolvedAt: Value(DateTime.now()),
  );

  static const _depositError = OffRampOrderRowsCompanion(
    status: Value(OffRampOrderStatus.depositTxConfirmError),
  );

  static const _processRefund = OffRampOrderRowsCompanion(
    status: Value(OffRampOrderStatus.processingRefund),
  );
}

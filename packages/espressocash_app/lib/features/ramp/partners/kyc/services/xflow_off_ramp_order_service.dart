import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../../config.dart';
import '../../../../../data/db/db.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../accounts/models/ec_wallet.dart';
import '../../../../analytics/analytics_manager.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../kyc_sharing/data/kyc_repository.dart';
import '../../../../kyc_sharing/models/kyc_order_status.dart';
import '../../../../kyc_sharing/utils/kyc_utils.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../tokens/token.dart';
import '../../../../transactions/models/tx_results.dart';
import '../../../../transactions/services/resign_tx.dart';
import '../../../../transactions/services/tx_sender.dart';

@Singleton(scope: authScope)
class XFlowOffRampOrderService implements Disposable {
  XFlowOffRampOrderService(
    this._db,
    this._kycRepository,
    this._analytics,
    this._ecClient,
    this._sender,
    this._account,
  );

  final ECWallet _account;
  final MyDatabase _db;
  final KycRepository _kycRepository;
  final AnalyticsManager _analytics;

  final EspressoCashClient _ecClient;
  final TxSender _sender;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, StreamSubscription<void>> _watchers = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final query = _db.select(_db.offRampOrderRows)
      ..where(
        (tbl) =>
            tbl.status.isNotInValues([
              OffRampOrderStatus.completed,
              OffRampOrderStatus.cancelled,
              OffRampOrderStatus.refunded,
              OffRampOrderStatus.rejected,
            ]) &
            tbl.partner.equalsValue(RampPartner.xflow),
      );

    final orders = await query.get();

    for (final order in orders) {
      if (order.partner != RampPartner.xflow) {
        continue;
      }

      _subscribe(order.id);
    }
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = (_db.select(_db.offRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingleOrNull()
        .whereNotNull()
        .asyncExpand<OffRampOrderRowsCompanion?>((order) {
          switch (order.status) {
            case OffRampOrderStatus.waitingPartnerReview:
              _waitingPartnerReviewWatcher(order);

              return const Stream.empty();

            case OffRampOrderStatus.creatingDepositTx:
              final amount = CryptoAmount(
                value: order.amount,
                cryptoCurrency: const CryptoCurrency(token: Token.usdc),
              );

              return Stream.fromFuture(
                _createTx(
                  amount: amount,
                  receiver: Ed25519HDPublicKey.fromBase58(order.depositAddress),
                ),
              ).onErrorReturn(
                const OffRampOrderRowsCompanion(
                  status: Value(OffRampOrderStatus.depositError),
                ),
              );

            case OffRampOrderStatus.depositTxReady:
              return Stream.value(
                const OffRampOrderRowsCompanion(
                  status: Value(OffRampOrderStatus.sendingDepositTx),
                ),
              );

            case OffRampOrderStatus.sendingDepositTx:
              final tx = SignedTx.decode(order.transaction)
                  .let((it) => (it, order.slot));

              return Stream.fromFuture(_sendTx(tx));

            case OffRampOrderStatus.waitingForPartner:
              _waitingForPartnerWatcher(order);

              return const Stream.empty();

            case OffRampOrderStatus.completed:
            case OffRampOrderStatus.rejected:
            case OffRampOrderStatus.cancelled:
              _subscriptions.remove(orderId)?.cancel();

              _watchers[orderId]?.cancel();
              _watchers.remove(orderId);

              return const Stream.empty();

            case OffRampOrderStatus.waitingUserVerification:
            case OffRampOrderStatus.preProcessing:
            case OffRampOrderStatus.postProcessing:
            case OffRampOrderStatus.ready:
            case OffRampOrderStatus.insufficientFunds:
            case OffRampOrderStatus.processingRefund:
            case OffRampOrderStatus.waitingForRefundBridge:
            case OffRampOrderStatus.refunded:
            case OffRampOrderStatus.depositError:
            case OffRampOrderStatus.depositTxConfirmError:
            case OffRampOrderStatus.depositTxRequired:
            case OffRampOrderStatus.failure:
              return const Stream.empty();
          }
        })
        .whereNotNull()
        .listen(
          (event) => (_db.update(_db.offRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId)))
              .write(event),
        );
  }

  AsyncResult<String> createPreOrder({
    required CryptoAmount submittedAmount,
    required FiatAmount receiveAmount,
  }) =>
      tryEitherAsync((_) async {
        {
          final order = OffRampOrderRow(
            id: const Uuid().v4(),
            partnerOrderId: '',
            amount: submittedAmount.value,
            token: Token.usdc.address,
            receiveAmount: receiveAmount.value,
            fiatSymbol: receiveAmount.fiatCurrency.symbol,
            created: DateTime.now(),
            humanStatus: '',
            machineStatus: '',
            partner: RampPartner.xflow,
            status: OffRampOrderStatus.waitingUserVerification,
            transaction: '',
            depositAddress: '',
            slot: BigInt.zero,
            bridgeAmount: null,
          );

          await _db.into(_db.offRampOrderRows).insert(order);

          return order.id;
        }
      });

  AsyncResult<String> createOrUpdate({
    required CryptoAmount submittedAmount,
    required FiatAmount receiveAmount,
    required String partnerAuthPk,
    String? preOrderId,
  }) =>
      tryEitherAsync((_) async {
        {
          await _kycRepository.grantPartnerAccess(partnerAuthPk);

          final user = await _kycRepository.fetchUser();

          final validUser = user?.let(
            (u) => u.accountNumber != null && u.bankCode != null ? u : null,
          );

          if (validUser == null) {
            throw Exception(
              'Invalid user data: User not found or missing bank information',
            );
          }

          final orderId = await _kycRepository.createOffRampOrder(
            cryptoAmount: submittedAmount.value.toString(),
            cryptoCurrency: submittedAmount.cryptoCurrency.token.symbol,
            fiatAmount: receiveAmount.value.toString(),
            fiatCurrency: receiveAmount.currency.symbol,
            partnerPK: partnerAuthPk,
            bankAccount: validUser.accountNumber ?? '',
            bankName: validUser.bankCode ?? '',
          );

          final order = OffRampOrderRow(
            id: preOrderId ?? const Uuid().v4(),
            partnerOrderId: orderId,
            amount: submittedAmount.value,
            token: Token.usdc.address,
            receiveAmount: receiveAmount.value,
            fiatSymbol: receiveAmount.fiatCurrency.symbol,
            created: DateTime.now(),
            humanStatus: '',
            machineStatus: '',
            partner: RampPartner.xflow,
            status: OffRampOrderStatus.waitingPartnerReview,
            transaction: '',
            depositAddress: '',
            slot: BigInt.zero,
            bridgeAmount: null,
          );

          await _db.into(_db.offRampOrderRows).insertOnConflictUpdate(order);
          _subscribe(order.id);

          final countryCode = await _kycRepository.fetchUser().letAsync(
                (user) => user?.countryCode ?? '',
              );

          _analytics.rampInitiated(
            partner: RampPartner.xflow,
            rampType: RampType.offRamp.name,
            amount: submittedAmount.value.toString(),
            countryCode: countryCode,
            id: order.id,
          );

          return order.id;
        }
      });

  void _waitingPartnerReviewWatcher(OffRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .listen((_) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(id),
        );

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = KycOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        KycOrderStatus.completed => OffRampOrderStatus.completed,
        KycOrderStatus.unknown ||
        KycOrderStatus.rejected =>
          OffRampOrderStatus.rejected,
        KycOrderStatus.failed => OffRampOrderStatus.failure,
        KycOrderStatus.pending => OffRampOrderStatus.waitingPartnerReview,
        KycOrderStatus.accepted => OffRampOrderStatus.creatingDepositTx,
      };

      if (status != order.status) {
        await statement.write(
          OffRampOrderRowsCompanion(
            status: Value.absentIfNull(status),
            depositAddress: Value.absentIfNull(orderData.cryptoWalletAddress),
          ),
        );

        _removeWatcher(id);
      }
    });
  }

  // Either complete or fail
  void _waitingForPartnerWatcher(OffRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10))
        .startWith(null)
        .listen((_) async {
      final statement = _db.update(_db.offRampOrderRows)
        ..where(
          (tbl) => tbl.id.equals(id),
        );

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = KycOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        KycOrderStatus.completed => OffRampOrderStatus.completed,
        KycOrderStatus.unknown ||
        KycOrderStatus.rejected =>
          OffRampOrderStatus.rejected,
        KycOrderStatus.failed => OffRampOrderStatus.failure,
        KycOrderStatus.pending => OffRampOrderStatus.waitingPartnerReview,
        KycOrderStatus.accepted => OffRampOrderStatus.creatingDepositTx,
      };

      if (status == OffRampOrderStatus.creatingDepositTx) return;

      if (status != order.status) {
        await statement.write(
          OffRampOrderRowsCompanion(
            status: Value.absentIfNull(status),
          ),
        );

        _removeWatcher(id);
      }
    });
  }

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
    final response = await _ecClient.createDirectPayment(dto);

    final tx = await SignedTx.decode(response.transaction)
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

  void _removeWatcher(String id) {
    _watchers.remove(id)?.cancel();
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    _watchers.values.map((it) => it.cancel());
  }

  final _depositError = const OffRampOrderRowsCompanion(
    status: Value(OffRampOrderStatus.depositTxConfirmError),
  );
}

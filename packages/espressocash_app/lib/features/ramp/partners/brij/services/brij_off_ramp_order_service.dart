import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../../data/db/db.dart';
import '../../../../../utils/errors.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../accounts/models/ec_wallet.dart';
import '../../../../analytics/analytics_manager.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../kyc_sharing/data/kyc_repository.dart';
import '../../../../kyc_sharing/utils/kyc_utils.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../tokens/token.dart';
import '../../../../transactions/models/tx_results.dart';
import '../../../../transactions/services/resign_tx.dart';
import '../../../../transactions/services/tx_sender.dart';
import '../../../services/extensions.dart';
import '../models/brij_order_status.dart';

@Singleton(scope: authScope)
class BrijOffRampOrderService implements Disposable {
  BrijOffRampOrderService(
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
    final query = _db.select(_db.offRampOrderRows)..where(
      (tbl) =>
          tbl.status.isNotInValues([
            OffRampOrderStatus.completed,
            OffRampOrderStatus.cancelled,
            OffRampOrderStatus.refunded,
            OffRampOrderStatus.rejected,
          ]) &
          tbl.partner.isInValues([RampPartner.brij]),
    );

    final orders = await query.get();

    for (final order in orders) {
      switch (order.partner) {
        case RampPartner.kado:
        case RampPartner.coinflow:
        case RampPartner.guardarian:
        case RampPartner.rampNetwork:
        case RampPartner.moneygram:
          // ignore: avoid-unnecessary-continue, needed here
          continue;
        case RampPartner.brij:
          _subscribe(order.id);
      }
    }
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = (_db.select(_db.offRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingleOrNull()
        .whereNotNull()
        .asyncExpand<OffRampOrderRowsCompanion?>((order) {
          if (order.shouldReportToSentry) {
            logMessage(message: 'BrijOffRampOrderStatusChange', data: order.toSentry());
          }

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
                const OffRampOrderRowsCompanion(status: Value(OffRampOrderStatus.depositError)),
              );

            case OffRampOrderStatus.depositTxReady:
              return Stream.value(
                const OffRampOrderRowsCompanion(status: Value(OffRampOrderStatus.sendingDepositTx)),
              );

            case OffRampOrderStatus.sendingDepositTx:
              final tx = SignedTx.decode(order.transaction).let((it) => (it, order.slot));

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
          (event) =>
              (_db.update(_db.offRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId))).write(event),
        );
  }

  AsyncResult<String> create({
    required CryptoAmount submittedAmount,
    required FiatAmount receiveAmount,
    required RampPartner partner,
    required String country,
  }) => tryEitherAsync((_) async {
    final partnerAuthPk = partner.partnerPK ?? '';
    await _kycRepository.grantPartnerAccess(partnerAuthPk);

    final user = await _kycRepository.fetchUser();

    final bank = user?.getBankByCountry(country);

    if (bank == null) {
      throw Exception('Invalid user data: User not found or missing bank information');
    }

    final orderId = await _kycRepository.createOffRampOrder(
      cryptoAmount: submittedAmount.decimal.toDouble(),
      cryptoCurrency: submittedAmount.cryptoCurrency.token.symbol,
      fiatAmount: receiveAmount.decimal.toDouble(),
      fiatCurrency: receiveAmount.currency.symbol,
      partnerPK: partnerAuthPk,
      cryptoWalletAddress: _account.publicKey.toString(),
      bankAccount: bank.accountNumber,
      bankName: bank.bankCode,
      walletPK: walletAuthPk,
    );

    final order = OffRampOrderRow(
      id: const Uuid().v4(),
      partnerOrderId: orderId,
      amount: submittedAmount.value,
      token: Token.usdc.address,
      receiveAmount: receiveAmount.value,
      fiatSymbol: receiveAmount.fiatCurrency.symbol,
      created: DateTime.now(),
      humanStatus: '',
      machineStatus: '',
      partner: partner,
      status: OffRampOrderStatus.waitingPartnerReview,
      transaction: '',
      depositAddress: '',
      slot: BigInt.zero,
      bridgeAmount: null,
    );

    await _db.into(_db.offRampOrderRows).insertOnConflictUpdate(order);
    _subscribe(order.id);

    _analytics.rampInitiated(
      partnerName: partner.name,
      rampType: RampType.offRamp.name,
      amount: submittedAmount.value.toString(),
      countryCode: country,
      id: order.id,
    );

    return order.id;
  });

  void _waitingPartnerReviewWatcher(OffRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10)).startWith(null).listen((
      _,
    ) async {
      final statement = _db.update(_db.offRampOrderRows)..where((tbl) => tbl.id.equals(id));

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = BrijOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        BrijOrderStatus.completed => OffRampOrderStatus.completed,
        BrijOrderStatus.unknown || BrijOrderStatus.rejected => OffRampOrderStatus.rejected,
        BrijOrderStatus.failed => OffRampOrderStatus.failure,
        BrijOrderStatus.pending => OffRampOrderStatus.waitingPartnerReview,
        BrijOrderStatus.accepted => OffRampOrderStatus.creatingDepositTx,
      };

      if (status != order.status) {
        await statement.write(
          OffRampOrderRowsCompanion(
            status: Value.ofNullable(status),
            depositAddress: Value.ofNullable(orderData.cryptoWalletAddress),
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

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 10)).startWith(null).listen((
      _,
    ) async {
      final statement = _db.update(_db.offRampOrderRows)..where((tbl) => tbl.id.equals(id));

      final orderData = await _kycRepository.fetchOrder(order.partnerOrderId);
      final kycStatus = BrijOrderStatus.fromString(orderData.status);

      final status = switch (kycStatus) {
        BrijOrderStatus.completed => OffRampOrderStatus.completed,
        BrijOrderStatus.unknown || BrijOrderStatus.rejected => OffRampOrderStatus.rejected,
        BrijOrderStatus.failed => OffRampOrderStatus.failure,
        BrijOrderStatus.pending => OffRampOrderStatus.waitingPartnerReview,
        BrijOrderStatus.accepted => OffRampOrderStatus.creatingDepositTx,
      };

      if (status == OffRampOrderStatus.creatingDepositTx) return;

      if (status != order.status) {
        await statement.write(OffRampOrderRowsCompanion(status: Value.ofNullable(status)));

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
      mintAddress: Currency.usdc.token.address,
    );
    final response = await _ecClient.createDirectPayment(dto);

    final tx = await SignedTx.decode(response.transaction).let((it) => it.resign(_account));

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
          status:
              reason == TxFailureReason.insufficientFunds
                  ? const Value(OffRampOrderStatus.insufficientFunds)
                  : const Value(OffRampOrderStatus.depositError),
          transaction: const Value(''),
          slot: Value(BigInt.zero),
        );
      case TxSendNetworkError():
        return _depositError;
    }

    final confirmed = await _sender.wait(tx.$1, minContextSlot: tx.$2, txType: 'OffRamp');

    return switch (confirmed) {
      TxWaitSuccess() => const OffRampOrderRowsCompanion(
        status: Value(OffRampOrderStatus.waitingForPartner),
      ),
      TxWaitFailure(:final reason) => OffRampOrderRowsCompanion(
        status:
            reason == TxFailureReason.insufficientFunds
                ? const Value(OffRampOrderStatus.insufficientFunds)
                : const Value(OffRampOrderStatus.depositTxConfirmError),
        transaction: const Value(''),
        slot: Value(BigInt.zero),
      ),
      TxWaitNetworkError() => _depositError,
    };
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

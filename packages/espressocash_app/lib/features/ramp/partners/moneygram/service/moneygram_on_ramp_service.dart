import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:drift/drift.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' hide Currency;
import 'package:uuid/uuid.dart';

import '../../../../../data/db/db.dart';
import '../../../../../utils/errors.dart';
import '../../../../accounts/auth_scope.dart';
import '../../../../accounts/models/ec_wallet.dart';
import '../../../../analytics/analytics_manager.dart';
import '../../../../balances/services/refresh_balance.dart';
import '../../../../currency/models/amount.dart';
import '../../../../currency/models/currency.dart';
import '../../../../ramp_partner/models/ramp_partner.dart';
import '../../../../ramp_partner/models/ramp_type.dart';
import '../../../../stellar/models/stellar_wallet.dart';
import '../../../../stellar/service/stellar_client.dart';
import '../../../../tokens/token.dart';
import '../../../../transactions/models/tx_results.dart';
import '../../../../transactions/services/tx_confirm.dart';
import '../../../services/extensions.dart';
import '../data/allbridge_client.dart';
import '../data/allbridge_dto.dart' hide TransactionStatus;
import '../data/dto.dart';
import '../data/moneygram_client.dart';

@Singleton(scope: authScope)
class MoneygramOnRampOrderService implements Disposable {
  MoneygramOnRampOrderService(
    this._ecWallet,
    this._ecClient,
    this._db,
    this._stellarWallet,
    this._stellarClient,
    this._moneygramClient,
    this._allbridgeApiClient,
    this._txConfirm,
    this._refreshBalance,
    this._analytics,
  );

  final MyDatabase _db;
  final TxConfirm _txConfirm;
  final RefreshBalance _refreshBalance;
  final AnalyticsManager _analytics;

  final ECWallet _ecWallet;
  final StellarWallet _stellarWallet;

  final StellarClient _stellarClient;
  final EspressoCashClient _ecClient;
  final MoneygramApiClient _moneygramClient;
  final AllbridgeApiClient _allbridgeApiClient;

  final Map<String, StreamSubscription<void>> _subscriptions = {};
  final Map<String, StreamSubscription<void>> _watchers = {};

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final query = _db.select(_db.onRampOrderRows)..where(
      (tbl) =>
          tbl.status.isNotInValues([OnRampOrderStatus.completed, OnRampOrderStatus.failure]) &
          tbl.partner.equalsValue(RampPartner.moneygram),
    );

    final orders = await query.get();

    for (final order in orders) {
      if (order.partner != RampPartner.moneygram) {
        continue;
      }

      _subscribe(order.id);
    }
  }

  void _subscribe(String orderId) {
    _subscriptions[orderId] = (_db.select(_db.onRampOrderRows)
          ..where((tbl) => tbl.id.equals(orderId)))
        .watchSingleOrNull()
        .whereNotNull()
        .asyncExpand<OnRampOrderRowsCompanion?>((order) {
          if (order.shouldReportToSentry) {
            logMessage(message: 'MGOnRampOrderStatusChange', data: order.toSentry());
          }

          switch (order.status) {
            case OnRampOrderStatus.pending:
              return Stream.fromFuture(_pendingOrder(order));

            case OnRampOrderStatus.preProcessing:
              return Stream.fromFuture(_preProcessingOrder(order));

            case OnRampOrderStatus.waitingForPartner:
              _waitingPartnerWatcher(order);

              return const Stream.empty();

            case OnRampOrderStatus.postProcessing:
              return Stream.fromFuture(_postProcessingOrder(order));

            case OnRampOrderStatus.waitingForBridge:
              _watchBridge(order);

              return const Stream.empty();

            case OnRampOrderStatus.completed:
            case OnRampOrderStatus.failure:
              _subscriptions.remove(orderId)?.cancel();

              _watchers[orderId]?.cancel();
              _watchers.remove(orderId);

              return const Stream.empty();

            case OnRampOrderStatus.waitingForDeposit:
            case OnRampOrderStatus.waitingPartnerReview:
            case OnRampOrderStatus.depositExpired:
            case OnRampOrderStatus.rejected:
              return const Stream.empty();
          }
        })
        .whereNotNull()
        .listen(
          (event) =>
              (_db.update(_db.onRampOrderRows)
                ..where((tbl) => tbl.id.equals(orderId))).write(event),
        );
  }

  AsyncResult<String> createPendingMoneygram({
    required String orderId,
    required FiatAmount submittedAmount,
    required String authToken,
    required CryptoAmount receiveAmount,
    required String countryCode,
    required CryptoAmount bridgeAmount,
  }) => tryEitherAsync((_) async {
    final order = OnRampOrderRow(
      id: const Uuid().v4(),
      partnerOrderId: orderId,
      amount: submittedAmount.value,
      fiatSymbol: submittedAmount.currency.symbol,
      receiveAmount: receiveAmount.value,
      token: Token.usdc.address,
      created: DateTime.now(),
      isCompleted: false,
      humanStatus: '',
      machineStatus: '',
      txHash: '',
      partner: RampPartner.moneygram,
      status: OnRampOrderStatus.pending,
      authToken: authToken,
      bridgeAmount: bridgeAmount.value,
    );

    await _db.into(_db.onRampOrderRows).insert(order);

    _analytics.rampInitiated(
      partnerName: RampPartner.moneygram.name,
      rampType: RampType.onRamp.name,
      amount: submittedAmount.value.toString(),
      countryCode: countryCode,
      id: order.id,
    );

    return order.id;
  });

  AsyncResult<void> updateMoneygramOrder({required String id}) => tryEitherAsync((_) async {
    final updateQuery = _db.update(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(id));

    await updateQuery.write(
      const OnRampOrderRowsCompanion(status: Value(OnRampOrderStatus.pending)),
    );

    _subscribe(id);
  });

  Future<OnRampOrderRowsCompanion?> _pendingOrder(OnRampOrderRow order) async {
    final orderId = order.partnerOrderId;
    String? token = order.authToken;

    token ??= await _stellarClient.fetchToken();

    final transaction = await _fetchTransactionStatus(id: orderId, token: token);

    final moreInfoUrl = transaction.moreInfoUrl;

    if (transaction.status == MgStatus.incomplete ||
        transaction.status == MgStatus.expired ||
        moreInfoUrl == null) {
      await _subscriptions.remove(orderId)?.cancel();
      _removeWatcher(order.id);

      await (_db.delete(_db.onRampOrderRows)..where((p) => p.id.equals(order.id))).go();

      return null;
    }

    final transferAmount =
        // ignore: avoid-type-casts, controlled type
        Amount.fromDecimal(
              value: Decimal.parse(transaction.amountIn ?? '0'),
              currency: currencyFromString(transaction.amountInAsset ?? 'USD'),
            )
            as FiatAmount;

    final feeAmount =
        // ignore: avoid-type-casts, controlled type
        Amount.fromDecimal(
              value: Decimal.parse(transaction.amountFee ?? '0'),
              currency: currencyFromString(transaction.amountFeeAsset ?? 'USD'),
            )
            as FiatAmount;

    return OnRampOrderRowsCompanion(
      bankTransferAmount: Value(transferAmount.value),
      feeAmount: Value(feeAmount.value),
      fiatSymbol: Value(transferAmount.currency.symbol),
      moreInfoUrl: Value(moreInfoUrl),
      bankName: const Value('moneygram'),
      bankTransferExpiry: Value(DateTime.now().add(const Duration(days: 1))),
      status: const Value(OnRampOrderStatus.preProcessing),
    );
  }

  Future<OnRampOrderRowsCompanion?> _preProcessingOrder(OnRampOrderRow order) async {
    final cashInAmount = CryptoAmount(
      value: order.bridgeAmount ?? 0,
      cryptoCurrency: Currency.usdc,
    );

    final xlmBalance = await _stellarClient.getXlmBalance();

    if (xlmBalance <= _minimumInitBalance) {
      final accountId = _stellarWallet.address;

      await _ecClient.fundXlmRequest(FundXlmRequestDto(accountId: accountId));
    }

    final hasUsdcTrustline = await _stellarClient.hasUsdcTrustline(
      amount: cashInAmount.decimal.toDouble(),
    );

    if (!hasUsdcTrustline) {
      await _stellarClient.createUsdcTrustline(limit: 10000);
    }

    return const OnRampOrderRowsCompanion(status: Value(OnRampOrderStatus.waitingForDeposit));
  }

  Future<OnRampOrderRowsCompanion?> _postProcessingOrder(OnRampOrderRow order) async {
    final existingHash = order.stellarTxHash;

    if (existingHash != null) {
      return const OnRampOrderRowsCompanion(status: Value(OnRampOrderStatus.waitingForBridge));
    }

    final amount = Amount.crypto(value: order.bridgeAmount ?? 0, cryptoCurrency: Currency.usdc);

    final solanaAddress = _ecWallet.address;

    final bridgeTx = await _ecClient
        .swapToSolana(
          SwapToSolanaRequestDto(
            amount: (amount.value - 20).toString(),
            stellarSenderAddress: _stellarWallet.address,
            solanaReceiverAddress: solanaAddress,
          ),
        )
        .then((e) => e.encodedTx);

    final hash = await _stellarClient.submitTransactionFromXdrString(bridgeTx);

    return hash == null
        ? const OnRampOrderRowsCompanion(status: Value(OnRampOrderStatus.postProcessing))
        : OnRampOrderRowsCompanion(
          stellarTxHash: Value(hash),
          status: const Value(OnRampOrderStatus.waitingForBridge),
        );
  }

  void _watchBridge(OnRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 30)).startWith(null).listen((
      _,
    ) async {
      final statement = _db.update(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(id));

      final hash = order.stellarTxHash;

      if (hash == null) {
        await statement.write(
          const OnRampOrderRowsCompanion(status: Value(OnRampOrderStatus.postProcessing)),
        );

        _removeWatcher(id);

        return;
      }

      final stellarResult = await _stellarClient.pollStatus(hash);
      if (stellarResult?.status != GetTransactionResponse.STATUS_SUCCESS) {
        await statement.write(
          const OnRampOrderRowsCompanion(status: Value(OnRampOrderStatus.postProcessing)),
        );

        _removeWatcher(id);

        return;
      }

      final response = await _allbridgeApiClient.fetchStatus(chain: Chain.stellar, hash: hash);

      final status = response?.receive;

      if (status == null) {
        return;
      }

      final solanaTxId = status.txId;
      final receiveAmount = int.tryParse(status.amount);

      final waitResult = await _txConfirm(txId: solanaTxId);
      if (waitResult != const TxWaitSuccess()) {
        return;
      }

      _refreshBalance();

      await statement.write(
        OnRampOrderRowsCompanion(
          status: const Value(OnRampOrderStatus.completed),
          isCompleted: const Value(true),
          txHash: Value(solanaTxId),
          receiveAmount: Value.ofNullable(receiveAmount),
        ),
      );

      _analytics.rampCompleted(
        partnerName: RampPartner.moneygram.name,
        rampType: RampType.onRamp.name,
        id: id,
      );

      _removeWatcher(id);
    });
  }

  void _waitingPartnerWatcher(OnRampOrderRow order) {
    final id = order.id;

    if (_watchers.containsKey(id)) {
      return;
    }

    _watchers[id] = Stream<void>.periodic(const Duration(seconds: 30)).startWith(null).listen((
      _,
    ) async {
      final statement = _db.update(_db.onRampOrderRows)..where((tbl) => tbl.id.equals(id));

      final amount = CryptoAmount(value: order.bridgeAmount ?? 0, cryptoCurrency: Currency.usdc);

      final orderId = order.partnerOrderId;
      String? token = order.authToken;

      token ??= await _stellarClient.fetchToken();

      final transaction = await _fetchTransactionStatus(id: orderId, token: token);

      if (transaction.status != MgStatus.completed) {
        // Not yet processed by MoneyGram
        return;
      }

      final usdcBalance = await _stellarClient.getUsdcBalance() ?? 0;

      if (usdcBalance == 0) {
        // Funds not received yet
        return;
      }

      if (usdcBalance < amount.decimal.toDouble()) {
        // Not enough funds
        logMessage(
          message: 'Received incorrect amount',
          data: {'balance': usdcBalance, 'requestedAmount': amount.decimal.toDouble()},
        );

        return;
      }

      await statement.write(
        OnRampOrderRowsCompanion(
          status: const Value.ofNullable(OnRampOrderStatus.postProcessing),
          referenceNumber: Value(transaction.externalTransactionId),
          moreInfoUrl: Value(transaction.moreInfoUrl),
          isCompleted: const Value(false),
        ),
      );

      _removeWatcher(id);
    });
  }

  Future<TransactionStatus> _fetchTransactionStatus({required String id, required String token}) =>
      _moneygramClient
          .fetchTransaction(id: id, authHeader: token, rampType: RampType.onRamp)
          .then((e) => e.transaction);

  void _removeWatcher(String id) {
    _watchers.remove(id)?.cancel();
  }

  @override
  Future<void> onDispose() async {
    await Future.wait(_subscriptions.values.map((it) => it.cancel()));
    _watchers.values.map((it) => it.cancel());
  }
}

const _minimumInitBalance = 1.5; // 1.5 XLM

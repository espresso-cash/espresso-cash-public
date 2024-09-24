import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' hide Currency;

import '../../accounts/auth_scope.dart';
import '../../accounts/models/account.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../balances/services/refresh_balance.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../ramp/partners/moneygram/data/allbridge_client.dart';
import '../../ramp/partners/moneygram/data/allbridge_dto.dart';
import '../../stellar/models/stellar_wallet.dart';
import '../../stellar/service/stellar_client.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/tx_confirm.dart';
import '../models/recovery_state.dart';

@Singleton(scope: authScope)
class StellarRecoveryService extends ValueNotifier<StellarRecoveryState> {
  StellarRecoveryService(
    this._ecWallet,
    this._stellarWallet,
    this._stellarClient,
    this._ecClient,
    this._account,
    this._storage,
    this._allbridgeApiClient,
    this._txConfirm,
    this._refreshBalance,
  ) : super(const StellarRecoveryState.none()) {
    addListener(_updateStorage);
  }

  final MyAccount _account;
  final ECWallet _ecWallet;
  final StellarWallet _stellarWallet;

  final StellarClient _stellarClient;
  final EspressoCashClient _ecClient;
  final AllbridgeApiClient _allbridgeApiClient;

  final SharedPreferences _storage;
  final TxConfirm _txConfirm;
  final RefreshBalance _refreshBalance;

  StreamSubscription<void>? _watcher;

  @PostConstruct()
  void init() {
    value = _getInitialState();

    switch (value) {
      case RecoveryNone():
        _checkAndInitiatePendingRecovery();
      case RecoveryProcessing():
        _watchBridgeTx();
      case RecoveryPending():
      case RecoveryCompleted():
      case RecoveryFailed():
      case RecoveryDismissed():
        break;
    }
  }

  StellarRecoveryState _getInitialState() {
    final status = _storage.getString(_stellarRecoveryStatusKey);
    final amount = _storage.getInt(_stellarRecoveryAmountKey).toCryptoAmount;
    final txId = _storage.getString(_stellarRecoveryTxIdKey) ?? '';

    return switch (status) {
      'pending' => StellarRecoveryState.pending(amount: amount),
      'processing' =>
        StellarRecoveryState.processing(amount: amount, txId: txId),
      'completed' => StellarRecoveryState.completed(amount: amount, txId: txId),
      'failed' => const StellarRecoveryState.failed(),
      'dismissed' => const StellarRecoveryState.dismissed(),
      _ => const StellarRecoveryState.none(),
    };
  }

  Future<void> _checkAndInitiatePendingRecovery() async {
    if (!_account.accessMode.isSeedInputted) return;

    final usdcBalance = await _stellarClient.getUsdcBalance();

    if (usdcBalance == null || usdcBalance.isEmpty) return;

    final fee = await _ecClient.calculateMoneygramFee(
      MoneygramFeeRequestDto(
        type: RampTypeDto.onRamp,
        amount: usdcBalance.toString(),
      ),
    );

    final amount = Amount.fromDecimal(
      value: Decimal.parse(fee.totalAmount),
      currency: Currency.usdc,
    ) as CryptoAmount;

    value = StellarRecoveryState.pending(amount: amount);
  }

  Future<void> recover() async {
    if (value is! RecoveryPending && value is! RecoveryFailed) return;

    value = const StellarRecoveryState.processing();

    try {
      final usdcBalance = await _stellarClient.getUsdcBalance();
      if (usdcBalance == null || usdcBalance.isEmpty) {
        value = const StellarRecoveryState.none();

        return;
      }

      final walletAmount = Amount.fromDecimal(
        value: Decimal.parse(usdcBalance.toString()),
        currency: Currency.usdc,
      ) as CryptoAmount;

      final hash = await _initiateSwapToSolana(walletAmount);

      final receivedAmount =
          _storage.getInt(_stellarRecoveryAmountKey).toCryptoAmount;

      value =
          StellarRecoveryState.processing(amount: receivedAmount, txId: hash);

      _watchBridgeTx();
    } on Exception {
      value = const StellarRecoveryState.failed();
    }
  }

  Future<String> _initiateSwapToSolana(CryptoAmount amount) async {
    final bridgeTx = await _ecClient
        .swapToSolana(
          SwapToSolanaRequestDto(
            amount: (amount.value - 10).toString(),
            stellarSenderAddress: _stellarWallet.address,
            solanaReceiverAddress: _ecWallet.address,
          ),
        )
        .then((e) => e.encodedTx);

    final hash = await _stellarClient.submitTransactionFromXdrString(bridgeTx);
    if (hash == null) throw Exception();

    final result = await _stellarClient.pollStatus(hash);
    if (result?.status != GetTransactionResponse.STATUS_SUCCESS) {
      throw Exception();
    }

    return hash;
  }

  void dismiss() {
    if (value is! RecoveryCompleted) {
      return;
    }

    value = const StellarRecoveryState.dismissed();
  }

  void _watchBridgeTx() {
    final txId = switch (value) {
      RecoveryProcessing(:final txId) => txId,
      _ => null,
    };

    if (txId == null || txId.isEmpty) {
      _watcher?.cancel();

      value = StellarRecoveryState.pending(
        amount: _storage.getInt(_stellarRecoveryAmountKey).toCryptoAmount,
      );

      return;
    }

    _watcher =
        Stream<void>.periodic(const Duration(seconds: 5)).listen((_) async {
      final response = await _allbridgeApiClient.fetchStatus(
        chain: Chain.stellar,
        hash: txId,
      );

      final status = response?.receive;

      if (status == null) {
        return;
      }

      final solanaTxId = status.txId;

      final waitResult = await _txConfirm(txId: solanaTxId);
      if (waitResult != const TxWaitSuccess()) {
        return;
      }

      _refreshBalance();

      value = StellarRecoveryState.completed(
        amount: value.amount ??
            const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc),
        txId: txId,
      );

      await _watcher?.cancel();
    });
  }

  void _updateStorage() {
    switch (value) {
      case RecoveryPending(:final amount):
        _storage
          ..setString(_stellarRecoveryStatusKey, 'pending')
          ..setInt(_stellarRecoveryAmountKey, amount.value);
      case RecoveryProcessing(:final txId):
        _storage
          ..setString(_stellarRecoveryStatusKey, 'processing')
          ..setString(_stellarRecoveryTxIdKey, txId ?? '');
      case RecoveryCompleted():
        _storage.setString(_stellarRecoveryStatusKey, 'completed');
      case RecoveryFailed():
        _storage.setString(_stellarRecoveryStatusKey, 'failed');
      case RecoveryDismissed():
        _storage.setString(_stellarRecoveryStatusKey, 'dismissed');
      case RecoveryNone():
        break;
    }
  }

  @override
  @disposeMethod
  void dispose() {
    removeListener(_updateStorage);
    _watcher?.cancel();

    _storage
      ..remove(_stellarRecoveryStatusKey)
      ..remove(_stellarRecoveryAmountKey)
      ..remove(_stellarRecoveryTxIdKey);
    super.dispose();
  }
}

extension on double {
  bool get isEmpty => this <= _minimumAmount;
}

extension on int? {
  CryptoAmount get toCryptoAmount => CryptoAmount(
        value: this ?? 0,
        cryptoCurrency: Currency.usdc,
      );
}

// Cannot bridge less than this amount
const _minimumAmount = 2.0;

const _stellarRecoveryStatusKey = 'stellarRecoveryStatus';
const _stellarRecoveryAmountKey = 'stellarRecoveryAmount';
const _stellarRecoveryTxIdKey = 'stellarRecoveryTxId';

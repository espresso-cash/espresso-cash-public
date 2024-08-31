import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
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
import '../../transactions/models/tx_results.dart';
import '../../transactions/services/tx_confirm.dart';
import '../models/stellar_wallet.dart';
import 'stellar_client.dart';

part 'recovery_service.freezed.dart';

@freezed
class StellarRecoveryState with _$StellarRecoveryState {
  const factory StellarRecoveryState.none() = RecoveryNone;
  const factory StellarRecoveryState.pending({
    required CryptoAmount amount,
  }) = RecoveryPending;
  const factory StellarRecoveryState.processing({
    CryptoAmount? amount,
    String? txId,
  }) = RecoveryProcessing;
  const factory StellarRecoveryState.completed({
    required CryptoAmount amount,
    required String txId,
  }) = RecoveryCompleted;
  const factory StellarRecoveryState.failed() = RecoveryFailed;
  const factory StellarRecoveryState.dismissed() = RecoveryDismissed;
}

extension StellarRecoveryStateX on StellarRecoveryState {
  CryptoAmount? get amount => maybeMap(
        pending: (e) => e.amount,
        processing: (e) => e.amount,
        completed: (e) => e.amount,
        orElse: () => null,
      );
}

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
  Future<void> init() async {
    final status = _storage.getString(_stellarRecoveryStatusKey);

    value = switch (status) {
      'pending' => StellarRecoveryState.pending(
          amount: _storage.getInt(_stellarRecoveryAmountKey).toCryptoAmount,
        ),
      'processing' => StellarRecoveryState.processing(
          amount: _storage.getInt(_stellarRecoveryAmountKey).toCryptoAmount,
          txId: _storage.getString(_stellarRecoveryTxIdKey) ?? '',
        ),
      'completed' => StellarRecoveryState.completed(
          amount: _storage.getInt(_stellarRecoveryAmountKey).toCryptoAmount,
          txId: _storage.getString(_stellarRecoveryTxIdKey) ?? '',
        ),
      'failed' => const StellarRecoveryState.failed(),
      'dismissed' => const StellarRecoveryState.dismissed(),
      _ => const StellarRecoveryState.none(),
    };

    if (value is RecoveryNone) {
      final isSeedInputted = _account.accessMode.isSeedInputted;

      if (!isSeedInputted) {
        return;
      }

      final usdcBalance = await _stellarClient.getUsdcBalance();

      if (usdcBalance == null || usdcBalance.isEmpty) {
        return;
      }

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

    if (value is RecoveryProcessing) {
      await _watchBridgeTx();
    }
  }

  Future<void> recover() async {
    if (value is! RecoveryPending && value is! RecoveryFailed) {
      return;
    }

    value = const StellarRecoveryState.processing();

    try {
      final usdcBalance = await _stellarClient.getUsdcBalance();

      if (usdcBalance == null || usdcBalance.isEmpty) {
        throw Exception('No USDC balance found');
      }

      final amount = Amount.fromDecimal(
        value: Decimal.parse(usdcBalance.toString()),
        currency: Currency.usdc,
      ) as CryptoAmount;

      final bridgeTx = await _ecClient
          .swapToSolana(
            SwapToSolanaRequestDto(
              amount: (amount.value - 10).toString(),
              stellarSenderAddress: _stellarWallet.address,
              solanaReceiverAddress: _ecWallet.address,
            ),
          )
          .then((e) => e.encodedTx);

      final hash =
          await _stellarClient.submitTransactionFromXdrString(bridgeTx);

      if (hash == null) {
        throw Exception('Failed to submit transaction');
      }

      final result = await _stellarClient.pollStatus(hash);

      if (result?.status != GetTransactionResponse.STATUS_SUCCESS) {
        throw Exception('Failed to recover USDC');
      }

      value = StellarRecoveryState.processing(amount: value.amount, txId: hash);

      await _watchBridgeTx();
    } on Exception {
      value = const StellarRecoveryState.failed();
    }
  }

  void dismiss() {
    if (value is! RecoveryCompleted) {
      return;
    }

    value = const StellarRecoveryState.dismissed();
  }

  Future<void> _watchBridgeTx() async {
    _watcher =
        Stream<void>.periodic(const Duration(seconds: 30)).listen((_) async {
      final txId = value.maybeMap(
        processing: (e) => e.txId,
        orElse: () => null,
      );

      if (txId == null) {
        return;
      }

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
        amount: value.amount!,
        txId: txId,
      );

      await _watcher?.cancel();
    });
  }

  void _updateStorage() {
    value.when(
      none: () {},
      pending: (amount) {
        _storage
          ..setString(_stellarRecoveryStatusKey, 'pending')
          ..setInt(_stellarRecoveryAmountKey, amount.value);
      },
      processing: (amount, txId) {
        _storage
          ..setString(_stellarRecoveryStatusKey, 'processing')
          ..setInt(_stellarRecoveryAmountKey, amount?.value ?? 0)
          ..setString(_stellarRecoveryTxIdKey, txId ?? '');
      },
      completed: (amount, txId) {
        _storage
          ..setString(_stellarRecoveryStatusKey, 'completed')
          ..setInt(_stellarRecoveryAmountKey, amount.value)
          ..setString(_stellarRecoveryTxIdKey, txId);
      },
      failed: () {
        _storage.setString(_stellarRecoveryStatusKey, 'failed');
      },
      dismissed: () {
        _storage.setString(_stellarRecoveryStatusKey, 'dismissed');
      },
    );
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

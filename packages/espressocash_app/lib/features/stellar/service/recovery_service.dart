import 'package:decimal/decimal.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' hide Currency;

import '../../accounts/auth_scope.dart';
import '../../accounts/models/account.dart';
import '../../accounts/models/ec_wallet.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../models/stellar_wallet.dart';
import 'stellar_client.dart';

@Singleton(scope: authScope)
class StellarRecoveryService extends ChangeNotifier {
  StellarRecoveryService(
    this._ecWallet,
    this._stellarWallet,
    this._stellarClient,
    this._ecClient,
    this._account,
    this._storage,
  );

  final MyAccount _account;
  final ECWallet _ecWallet;
  final StellarWallet _stellarWallet;

  final StellarClient _stellarClient;
  final EspressoCashClient _ecClient;

  final SharedPreferences _storage;

  bool _hasStellarUsdc = false;
  bool get hasStellarUsdc => _hasStellarUsdc;

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    final hasRecoveryKey = _storage.getBool(_stellarRecoverKey) == true;
    final isSeedInputted = _account.accessMode.isSeedInputted;

    if (!hasRecoveryKey && !isSeedInputted) {
      return;
    }

    final usdcBalance = await _stellarClient.getUsdcBalance();

    if (usdcBalance == null || usdcBalance.isEmpty) {
      return;
    }

    _hasStellarUsdc = true;

    await _storage.setBool(_stellarRecoverKey, true);

    notifyListeners();
  }

  Future<void> recover() async {
    final usdcBalance = await _stellarClient.getUsdcBalance();

    if (usdcBalance == null || usdcBalance.isEmpty) {
      throw Exception('No USDC balance found');
    }

    final amount = Amount.fromDecimal(
      value: Decimal.parse(usdcBalance.toString()),
      currency: Currency.usdc,
    );

    final bridgeTx = await _ecClient
        .swapToSolana(
          SwapToSolanaRequestDto(
            amount: amount.value.toString(),
            stellarSenderAddress: _stellarWallet.address,
            solanaReceiverAddress: _ecWallet.address,
          ),
        )
        .then((e) => e.encodedTx);

    final hash = await _stellarClient.submitTransactionFromXdrString(bridgeTx);

    if (hash == null) {
      throw Exception('Failed to submit transaction');
    }

    final result = await _stellarClient.pollStatus(hash);

    if (result?.status != GetTransactionResponse.STATUS_SUCCESS) {
      throw Exception('Failed to recover USDC');
    }

    _hasStellarUsdc = false;

    await _storage.setBool(_stellarRecoverKey, false);

    notifyListeners();
  }

  @override
  @disposeMethod
  void dispose() {
    _storage.remove(_stellarRecoverKey);
    super.dispose();
  }
}

extension on double {
  bool get isEmpty => this <= _minimumAmount;
}

// Cannot bridge less than this amount
const _minimumAmount = 2.0;
const _stellarRecoverKey = 'stellarRecoverKey';

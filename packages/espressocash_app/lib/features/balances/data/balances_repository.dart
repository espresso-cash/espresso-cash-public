import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../accounts/auth_scope.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';

@Singleton(scope: authScope)
class BalancesRepository extends ChangeNotifier {
  BalancesRepository(this._storage);

  final SharedPreferences _storage;

  @PostConstruct()
  void init() {
    final balance = _storage.getInt(_usdcBalanceKey);

    if (balance == null) return;

    _usdcBalance.add(
      CryptoAmount(
        value: balance,
        cryptoCurrency: const CryptoCurrency(token: Token.usdc),
      ),
    );
    notifyListeners();
  }

  final _usdcBalance = BehaviorSubject<CryptoAmount>.seeded(
    const CryptoAmount(
      value: 0,
      cryptoCurrency: CryptoCurrency(token: Token.usdc),
    ),
  );

  void save(CryptoAmount balance) {
    if (balance.cryptoCurrency.token != Token.usdc) {
      throw ArgumentError('Only USDC balances can be saved.');
    }

    _usdcBalance.add(balance);
    _storage.setInt(_usdcBalanceKey, balance.value);
    notifyListeners();
  }

  CryptoAmount read() => _usdcBalance.value;

  (Stream<CryptoAmount>, CryptoAmount) watch() => (_usdcBalance.stream, read());

  @override
  @disposeMethod
  void dispose() {
    _usdcBalance.close();
    _storage.remove(_usdcBalanceKey);
    super.dispose();
  }
}

const _usdcBalanceKey = 'usdcBalance';

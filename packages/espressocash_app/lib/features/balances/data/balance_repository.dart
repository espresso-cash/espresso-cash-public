import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../authenticated/auth_scope.dart';
import '../../tokens/token.dart';
import 'balance_cache_repository.dart';

@Singleton(scope: authScope)
class BalanceRepository extends ChangeNotifier {
  BalanceRepository(this._cache);

  final BalanceCacheRepository _cache;

  @PostConstruct()
  void init() {
    final balance = _cache.balance;

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
    notifyListeners();

    _cache.saveBalance(balance.value);
  }

  CryptoAmount read() => _usdcBalance.value;

  (Stream<CryptoAmount>, CryptoAmount) watch() => (_usdcBalance.stream, read());

  @override
  @disposeMethod
  void dispose() {
    _usdcBalance.close();
    _cache.clear();

    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../authenticated/auth_scope.dart';
import '../../tokens/token.dart';

@Singleton(scope: authScope)
class BalancesRepository extends ChangeNotifier {
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
  }

  CryptoAmount read() => _usdcBalance.value;

  (Stream<CryptoAmount>, CryptoAmount) watch() => (_usdcBalance.stream, read());

  @override
  void dispose() {
    _usdcBalance.close();
    super.dispose();
  }
}

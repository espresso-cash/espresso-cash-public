import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

typedef Balances = IMap<Token, Amount>;

extension BalanceExt on Balances {
  bool isPositive(Token token) {
    final balance = this[token];

    return balance != null && balance.value > 0;
  }

  CryptoAmount balanceFromToken(Token token) {
    final balance = this[token];
    final value = balance?.value ?? 0;

    return CryptoAmount(value: value, currency: CryptoCurrency(token: token));
  }
}

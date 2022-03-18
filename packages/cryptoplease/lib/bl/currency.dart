import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'currency.freezed.dart';

@freezed
class Currency with _$Currency {
  const factory Currency.fiat({
    required String name,
    required int decimals,
    required String symbol,
  }) = FiatCurrency;

  const factory Currency.crypto({
    required Token token,
  }) = CryptoCurrency;

  const Currency._();

  static const CryptoCurrency sol = CryptoCurrency(token: Token.sol);

  static const FiatCurrency usd = FiatCurrency(
    symbol: 'USD',
    name: 'US dollar',
    decimals: 2,
  );

  String get name => map(fiat: (c) => c.name, crypto: (c) => c.token.name);

  int get decimals => map(
        fiat: (c) => c.decimals,
        crypto: (c) => c.token.decimals,
      );

  String get symbol => map(
        fiat: (c) => c.symbol,
        crypto: (c) => c.token.symbol,
      );

  int decimalToInt(Decimal value) =>
      value.shift(decimals).round().toBigInt().toInt();
}

import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../tokens/token.dart';

part 'currency.freezed.dart';

@Freezed(
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
)
sealed class Currency with _$Currency {
  const factory Currency.fiat({
    required String name,
    required int decimals,
    required String symbol,
    required String sign,
  }) = FiatCurrency;

  const factory Currency.crypto({
    required Token token,
  }) = CryptoCurrency;

  const Currency._();

  static const CryptoCurrency sol = CryptoCurrency(token: Token.sol);

  static const CryptoCurrency usdc = CryptoCurrency(token: Token.usdc);

  static const FiatCurrency usd = FiatCurrency(
    symbol: 'USD',
    sign: r'$',
    name: 'US dollar',
    decimals: 2,
  );

  static const FiatCurrency ngn = FiatCurrency(
    symbol: 'NGN',
    sign: '₦',
    name: 'Nigerian Naira',
    decimals: 2,
  );

  String get name => switch (this) {
        FiatCurrency(:final name) => name,
        CryptoCurrency(:final token) => token.name,
      };

  int get decimals => switch (this) {
        FiatCurrency(:final decimals) => decimals,
        CryptoCurrency(:final token) => token.decimals,
      };

  String get symbol => switch (this) {
        FiatCurrency(:final symbol) => symbol,
        CryptoCurrency(:final token) => token.symbol,
      };

  int decimalToInt(Decimal value) =>
      value.shift(decimals).round().toBigInt().toInt();
}

const defaultFiatCurrency = Currency.usd;

FiatCurrency currencyFromString(String currency) {
  switch (currency) {
    case 'USD':
      return Currency.usd;
    case 'NGN':
      return Currency.ngn;
    default:
      return _fallbackFiatCurrency(currency);
  }
}

FiatCurrency _fallbackFiatCurrency(String currency) => FiatCurrency(
      symbol: currency,
      sign: currency,
      name: currency,
      decimals: 2,
    );

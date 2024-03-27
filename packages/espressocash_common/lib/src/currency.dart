import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'token.dart';

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

import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'token.dart';

part 'currency.freezed.dart';

@Freezed(
  when: FreezedWhenOptions.none,
  map: FreezedMapOptions.none,
)
sealed class Currency with _$Currency {
  const factory Currency.crypto({
    required Token token,
  }) = CryptoCurrency;

  const Currency._();

  static const CryptoCurrency usdc = CryptoCurrency(token: Token.usdc);

  String get name => token.name;

  int get decimals => token.decimals;

  String get symbol => token.symbol;

  int decimalToInt(Decimal value) =>
      value.shift(decimals).round().toBigInt().toInt();
}

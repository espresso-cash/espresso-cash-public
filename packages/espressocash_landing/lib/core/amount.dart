import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'currency.dart';

part 'amount.freezed.dart';

@Freezed(when: FreezedWhenOptions.none, map: FreezedMapOptions.none)
sealed class Amount with _$Amount {
  factory Amount({required int value, required Currency currency}) =>
      Amount.crypto(value: value, cryptoCurrency: currency);

  const factory Amount.crypto({
    required int value,
    required Currency cryptoCurrency,
  }) = CryptoAmount;

  factory Amount.fromDecimal({
    required Decimal value,
    required Currency currency,
  }) =>
      Amount(value: currency.decimalToInt(value), currency: currency);

  const Amount._();

  Currency get currency => cryptoCurrency;

  Decimal get decimal => Decimal.fromInt(value).shift(-currency.decimals);

  Amount operator +(Amount other) {
    _ensureSameCurrency(other);

    return Amount(value: value + other.value, currency: currency);
  }

  Amount operator -(Amount other) {
    _ensureSameCurrency(other);

    return Amount(value: value - other.value, currency: currency);
  }

  bool operator >(Amount other) {
    _ensureSameCurrency(other);

    return value > other.value;
  }

  bool operator >=(Amount other) {
    _ensureSameCurrency(other);

    return value >= other.value;
  }

  bool operator <(Amount other) {
    _ensureSameCurrency(other);

    return value < other.value;
  }

  bool operator <=(Amount other) {
    _ensureSameCurrency(other);

    return value <= other.value;
  }

  void _ensureSameCurrency(Amount other) {
    if (currency != other.currency) {
      throw ArgumentError('cannot operate on different currencies');
    }
  }
}

extension AmountExt on Amount {
  Amount convert({required Decimal rate, required Currency to}) {
    final value = decimal * rate;

    return Amount.fromDecimal(value: value, currency: to);
  }
}

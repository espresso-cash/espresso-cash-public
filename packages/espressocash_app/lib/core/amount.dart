import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'currency.dart';
import 'tokens/token.dart';

part 'amount.freezed.dart';

@freezed
class Amount with _$Amount {
  factory Amount({required int value, required Currency currency}) =>
      currency.map(
        fiat: (c) => Amount.fiat(value: value, fiatCurrency: c),
        crypto: (c) => Amount.crypto(value: value, cryptoCurrency: c),
      );

  const factory Amount.fiat({
    required int value,
    required FiatCurrency fiatCurrency,
  }) = FiatAmount;

  const factory Amount.crypto({
    required int value,
    required CryptoCurrency cryptoCurrency,
  }) = CryptoAmount;

  factory Amount.zero({required Currency currency}) =>
      Amount(value: 0, currency: currency);

  factory Amount.fromToken({required int value, required Token token}) =>
      Amount(value: value, currency: Currency.crypto(token: token));

  factory Amount.sol({required int value}) =>
      Amount.crypto(value: value, cryptoCurrency: Currency.sol);

  factory Amount.fromDecimal({
    required Decimal value,
    required Currency currency,
  }) =>
      Amount(value: currency.decimalToInt(value), currency: currency);

  const Amount._();

  Currency get currency => map(
        fiat: (a) => a.fiatCurrency,
        crypto: (a) => a.cryptoCurrency,
      );

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

extension CryptoAmountExt on CryptoAmount {
  Token get token => cryptoCurrency.token;

  CryptoAmount copyWithDecimal(Decimal decimal) =>
      copyWith(value: currency.decimalToInt(decimal));
}

extension FiatAmountExt on FiatAmount {
  FiatAmount copyWithDecimal(Decimal decimal) =>
      copyWith(value: currency.decimalToInt(decimal));
}

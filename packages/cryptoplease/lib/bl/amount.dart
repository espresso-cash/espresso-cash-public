import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:decimal/decimal.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'amount.freezed.dart';

@freezed
class Amount with _$Amount {
  factory Amount({required int value, required Currency currency}) =>
      currency.map(
        fiat: (c) => Amount.fiat(value: value, currency: c),
        crypto: (c) => Amount.crypto(value: value, currency: c),
      );

  const factory Amount.fiat({
    required int value,
    required FiatCurrency currency,
  }) = FiatAmount;

  const factory Amount.crypto({
    required int value,
    required CryptoCurrency currency,
  }) = CryptoAmount;

  factory Amount.zero({required Currency currency}) =>
      Amount(value: 0, currency: currency);

  factory Amount.fromToken({required int value, required Token token}) =>
      Amount(value: value, currency: Currency.crypto(token: token));

  factory Amount.sol({required int value}) =>
      Amount.crypto(value: value, currency: Currency.sol);

  factory Amount.fromDecimal({
    required Decimal value,
    required Currency currency,
  }) =>
      Amount(value: currency.decimalToInt(value), currency: currency);

  const Amount._();

  Currency get currency => map(
        fiat: (a) => a.currency,
        crypto: (a) => a.currency,
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
      throw ArgumentError('cannot add different currencies');
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Amount && value == other.value && currency == other.currency;

  @override
  int get hashCode => Object.hash(value, currency);
}

extension AmountExt on Amount {
  Amount convert({required Decimal rate, required Currency to}) {
    final value = decimal * rate;

    return Amount.fromDecimal(value: value, currency: to);
  }
}

extension CryptoAmountExt on CryptoAmount {
  Token get token => currency.token;
}

import 'package:decimal/decimal.dart';

import '../amount.dart';
import '../currency.dart';
import '../tokens/token.dart';
import 'bl/repository.dart';

extension CryptoAmountExt on CryptoAmount {
  FiatAmount? toFiatAmount(
    FiatCurrency currency, {
    required ConversionRatesRepository ratesRepository,
  }) {
    final rate = ratesRepository.readRate(this.currency, to: currency);

    if (rate == null) return null;

    return convert(rate: rate, to: currency) as FiatAmount;
  }
}

extension FiatAmountExt on FiatAmount {
  CryptoAmount? toTokenAmount(
    Token token, {
    required ConversionRatesRepository ratesRepository,
  }) {
    final rate = ratesRepository.readRate(
      CryptoCurrency(token: token),
      to: currency,
    );

    if (rate == null) return null;

    final inverted = rate.inverse.toDecimal(
      scaleOnInfinitePrecision: token.decimals,
    );

    return convert(rate: inverted, to: CryptoCurrency(token: token))
        as CryptoAmount;
  }
}

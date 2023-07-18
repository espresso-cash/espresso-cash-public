import 'package:decimal/decimal.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../data/repository.dart';

extension CryptoAmountExt on CryptoAmount {
  FiatAmount? toFiatAmount(
    FiatCurrency currency, {
    required ConversionRatesRepository ratesRepository,
  }) {
    final rate = ratesRepository.readRate(cryptoCurrency, to: currency);

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
      to: fiatCurrency,
    );

    if (rate == null) return null;

    final inverted = rate.inverse.toDecimal(
      scaleOnInfinitePrecision: token.decimals,
    );

    return convert(rate: inverted, to: CryptoCurrency(token: token))
        as CryptoAmount;
  }
}

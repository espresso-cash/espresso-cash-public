import 'package:decimal/decimal.dart';
import 'package:espressocash_common/espressocash_common.dart';

import '../../../di.dart';
import '../data/repository.dart';

extension CryptoAmountExt on CryptoAmount {
  FiatAmount? toFiatAmount(
    FiatCurrency currency, {
    required ConversionRatesRepository ratesRepository,
  }) {
    final rate = ratesRepository.readRate(to: currency);

    if (rate == null) return null;

    return convert(rate: rate, to: currency) as FiatAmount;
  }
}

extension FiatAmountExt on FiatAmount {
  CryptoAmount? toTokenAmount(Token token) {
    final rate = sl<ConversionRatesRepository>().readRate(
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

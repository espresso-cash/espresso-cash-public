import 'package:decimal/decimal.dart';

import '../../../di.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../tokens/token.dart';
import '../data/cash_repository.dart';

extension CryptoAmountExt on CryptoAmount {
  FiatAmount? toFiatAmount(
    FiatCurrency currency, {
    required CashConversionRatesRepository ratesRepository,
  }) {
    final rate = ratesRepository.readRate(to: currency);

    if (rate == null) return null;

    return convert(rate: rate, to: currency) as FiatAmount;
  }
}

extension FiatAmountExt on FiatAmount {
  CryptoAmount? toTokenAmount(Token token) {
    final rate = sl<CashConversionRatesRepository>().readRate(
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

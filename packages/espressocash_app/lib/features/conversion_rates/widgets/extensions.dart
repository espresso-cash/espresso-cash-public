import 'package:decimal/decimal.dart';
import 'package:espressocash_common/dart.dart';
import 'package:espressocash_common/flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../data/repository.dart';

extension ConversionRates on BuildContext {
  Decimal? watchConversionRate({
    required FiatCurrency to,
  }) =>
      watch<ConversionRatesRepository>().readRate(to: to);
}

extension FormatAmountWithFiatExt on CryptoAmount {
  String formatWithFiat(BuildContext context) {
    const fiat = Currency.usd;
    final locale = context.locale;
    final formattedAmount = format(locale, maxDecimals: fiat.decimals);
    final conversionRate = context.watchConversionRate(to: fiat);

    if (conversionRate == null) return formattedAmount;

    final converted = convert(rate: conversionRate, to: Currency.usd);

    return '${converted.format(locale)} ($formattedAmount)';
  }
}

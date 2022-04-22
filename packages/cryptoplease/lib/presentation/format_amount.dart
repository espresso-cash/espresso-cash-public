import 'dart:math' as math;
import 'dart:ui';

import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

extension FormatAmount on Amount {
  String format(Locale? locale, {bool skipSymbol = false}) => currency.map(
        fiat: (FiatCurrency currency) => _formatAmount(
          locale: locale,
          value: decimal,
          decimals: currency.decimals,
          symbol: currency.symbol,
          skipSymbol: skipSymbol,
        ),
        crypto: (CryptoCurrency currency) => _formatAmount(
          locale: locale,
          value: decimal,
          decimals: currency.decimals,
          symbol: currency.symbol,
          skipSymbol: skipSymbol,
        ),
      );
}

String _formatAmount({
  Locale? locale,
  String? symbol,
  required Decimal value,
  required int decimals,
  required bool skipSymbol,
}) {
  late final NumberFormat formatter;
  formatter = NumberFormat.decimalPattern(locale?.languageCode)
    ..minimumFractionDigits = 2
    ..maximumFractionDigits = decimals;

  final minimum = 1 / math.pow(10, decimals);
  final currentValue = value.toDouble();

  final String formatted;
  if (currentValue < minimum) {
    final minFormatted = formatter.format(minimum);
    formatted = '< $minFormatted';
  } else {
    formatted = formatter.format(currentValue);
  }

  return skipSymbol ? formatted : '$formatted $symbol';
}

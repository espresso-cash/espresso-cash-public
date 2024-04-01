import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../dart.dart';

extension FormatAmountExt on Amount {
  String format(
    Locale locale, {
    bool skipSymbol = false,
    bool roundInteger = false,
    int? maxDecimals,
  }) =>
      switch (currency) {
        FiatCurrency(:final sign) => formatAmount(
            locale: locale,
            value: decimal,
            decimals: maxDecimals ?? currency.decimals,
            symbol: skipSymbol ? null : sign,
            prefixedSymbol: true,
            roundInteger: roundInteger,
          ),
        CryptoCurrency() => formatAmount(
            locale: locale,
            value: decimal,
            decimals: maxDecimals ?? currency.decimals,
            symbol: skipSymbol ? null : currency.symbol,
            prefixedSymbol: false,
            roundInteger: roundInteger,
          ),
      };
}

String formatAmount({
  required Locale locale,
  required Decimal value,
  required int decimals,
  required bool prefixedSymbol,
  required bool roundInteger,
  String? symbol,
}) {
  final minimumDigits = roundInteger && value.isInteger ? 0 : 2;

  final formatter = NumberFormat.decimalPattern(locale.languageCode)
    ..minimumFractionDigits = minimumDigits
    ..maximumFractionDigits = decimals;

  final formatted = formatter.format(value.toDouble());

  if (symbol == null) return formatted;

  return prefixedSymbol ? '$symbol$formatted' : '$formatted $symbol';
}

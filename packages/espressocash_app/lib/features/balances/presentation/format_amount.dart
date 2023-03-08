import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../l10n/device_locale.dart';
import '../../conversion_rates/context_ext.dart';

extension FormatAmountWithFiatExt on CryptoAmount {
  String formatWithFiat(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = format(locale);
    final conversionRate = context.watchConversionRate(
      from: cryptoCurrency.token,
      to: Currency.usd,
    );
    if (conversionRate == null) return formattedAmount;

    final converted = convert(rate: conversionRate, to: Currency.usd);

    return '${converted.format(locale)} ($formattedAmount)';
  }
}

extension FormatAmountExt on Amount {
  String format(
    Locale locale, {
    bool skipSymbol = false,
    bool roundInteger = false,
  }) =>
      currency.map(
        fiat: (FiatCurrency currency) => formatAmount(
          locale: locale,
          value: decimal,
          decimals: currency.decimals,
          symbol: skipSymbol ? null : currency.sign,
          prefixedSymbol: true,
          roundInteger: roundInteger,
        ),
        crypto: (CryptoCurrency currency) => formatAmount(
          locale: locale,
          value: decimal,
          decimals: currency.decimals,
          symbol: skipSymbol ? null : currency.symbol,
          prefixedSymbol: false,
          roundInteger: roundInteger,
        ),
      );
}

String formatAmount({
  required Locale locale,
  required Decimal value,
  required int decimals,
  required bool prefixedSymbol,
  required bool roundInteger,
  String? symbol,
}) {
  late final NumberFormat formatter;
  final minimumDigits = roundInteger && value.isInteger ? 0 : 2;

  formatter = NumberFormat.decimalPattern(locale.languageCode)
    ..minimumFractionDigits = minimumDigits
    ..maximumFractionDigits = decimals;

  final formatted = formatter.format(value.toDouble());

  if (symbol == null) return formatted;

  return prefixedSymbol ? '$symbol$formatted' : '$formatted $symbol';
}

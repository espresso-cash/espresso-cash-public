import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../features/payment_request/bl/payment_request.dart';
import '../../l10n/device_locale.dart';
import '../amount.dart';
import '../conversion_rates/presentation/conversion_rates.dart';
import '../currency.dart';
import '../tokens/token_list.dart';

extension FormatAmountWithFiatExt on CryptoAmount {
  String formatWithFiat(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = format(locale);
    final conversionRate = context.watchConversionRate(
      from: currency.token,
      to: Currency.usd,
    );
    if (conversionRate == null) return formattedAmount;

    final converted = convert(rate: conversionRate, to: Currency.usd);

    return '${converted.format(locale)} ($formattedAmount)';
  }
}

extension FormatAmountExt on Amount {
  String format(Locale? locale, {bool skipSymbol = false}) => currency.map(
        fiat: (FiatCurrency currency) => _formatAmount(
          locale: locale,
          value: decimal,
          decimals: currency.decimals,
          symbol: currency.sign,
          skipSymbol: skipSymbol,
          prefixedSymbol: true,
        ),
        crypto: (CryptoCurrency currency) => _formatAmount(
          locale: locale,
          value: decimal,
          decimals: currency.decimals,
          symbol: currency.symbol,
          skipSymbol: skipSymbol,
          prefixedSymbol: false,
        ),
      );
}

extension PaymentRequestFormatAmountExt on PaymentRequest {
  String formattedAmount(Locale? locale) =>
      payRequest.cryptoAmount(TokenList())?.format(locale) ?? '';
}

String _formatAmount({
  Locale? locale,
  String? symbol,
  required Decimal value,
  required int decimals,
  required bool skipSymbol,
  required bool prefixedSymbol,
}) {
  late final NumberFormat formatter;
  formatter = NumberFormat.decimalPattern(locale?.languageCode)
    ..minimumFractionDigits = 2
    ..maximumFractionDigits = decimals;

  final formatted = formatter.format(value.toDouble());

  if (skipSymbol) {
    return formatted;
  }

  return prefixedSymbol ? '$symbol$formatted' : '$formatted $symbol';
}

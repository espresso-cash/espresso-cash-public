import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
  String format(
    Locale? locale, {
    bool skipSymbol = false,
    bool roundInteger = false,
    int? decimals,
  }) =>
      currency.map(
        fiat: (FiatCurrency currency) => _formatAmount(
          locale: locale,
          value: decimal,
          decimals: decimals ?? currency.decimals,
          symbol: currency.sign,
          skipSymbol: skipSymbol,
          prefixedSymbol: true,
          roundInteger: roundInteger,
        ),
        crypto: (CryptoCurrency currency) => _formatAmount(
          locale: locale,
          value: decimal,
          decimals: decimals ?? currency.decimals,
          symbol: currency.symbol,
          skipSymbol: skipSymbol,
          prefixedSymbol: false,
          roundInteger: roundInteger,
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
  required bool roundInteger,
}) {
  late final NumberFormat formatter;
  final minimumDigits = roundInteger && value.isInteger ? 0 : 2;

  formatter = NumberFormat.decimalPattern(locale?.languageCode)
    ..minimumFractionDigits = minimumDigits
    ..maximumFractionDigits = decimals;

  final formatted = formatter.format(value.toDouble());

  if (skipSymbol) {
    return formatted;
  }

  return prefixedSymbol ? '$symbol$formatted' : '$formatted $symbol';
}

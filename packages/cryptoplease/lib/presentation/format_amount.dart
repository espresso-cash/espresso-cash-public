import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/conversion_rates.dart';
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

    return '$formattedAmount (${converted.format(locale)})';
  }
}

extension FormatAmountExt on Amount {
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
}) {
  late final NumberFormat formatter;
  formatter = NumberFormat.decimalPattern(locale?.languageCode)
    ..minimumFractionDigits = 2
    ..maximumFractionDigits = decimals;

  final formatted = formatter.format(value.toDouble());

  return skipSymbol ? formatted : '$formatted $symbol';
}

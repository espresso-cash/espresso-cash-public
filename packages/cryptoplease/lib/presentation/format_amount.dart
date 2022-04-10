import 'dart:ui';

import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

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

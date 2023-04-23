import 'dart:ui';

import 'package:decimal/decimal.dart';

import '../currency.dart';
import 'format_amount.dart';

extension DecimalExt on Decimal? {
  String formatDisplayablePrice({
    required Locale locale,
    required FiatCurrency currency,
    bool skipSymbol = false,
  }) {
    final price = this;

    if (price == null) return '-';

    return formatAmount(
      locale: locale,
      value: price,
      decimals: price < Decimal.parse('0.01') ? 7 : currency.decimals,
      prefixedSymbol: true,
      roundInteger: false,
      symbol: skipSymbol ? null : currency.sign,
    );
  }
}

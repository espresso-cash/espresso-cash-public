import 'package:decimal/decimal.dart';

import '../currency.dart';
import 'format_amount.dart';

extension DecimalExt on Decimal? {
  String formatDisplayablePrice({required FiatCurrency currency}) {
    final price = this;

    if (price == null) return '-';

    return formatAmount(
      value: price,
      decimals: price < Decimal.parse('0.01') ? 7 : currency.decimals,
      prefixedSymbol: true,
      roundInteger: false,
      symbol: currency.sign,
    );
  }
}

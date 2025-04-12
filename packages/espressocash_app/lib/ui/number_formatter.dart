import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

extension NumberFormatterExt on String {
  Decimal toDecimalOrZero(Locale locale) {
    try {
      final formatter = NumberFormat.decimalPattern(locale.languageCode)..minimumFractionDigits = 2;
      final formatted = formatter.parse(this);

      return Decimal.tryParse(formatted.toString()) ?? Decimal.zero;
    } on FormatException catch (_) {
      return Decimal.zero;
    }
  }
}

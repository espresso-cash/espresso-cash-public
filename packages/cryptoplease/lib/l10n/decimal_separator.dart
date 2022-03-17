import 'package:flutter/widgets.dart';
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

String getDecimalSeparator(Locale locale) =>
    // ignore: avoid_dynamic_calls
    numberFormatSymbols[locale.languageCode]?.DECIMAL_SEP as String? ?? '.';

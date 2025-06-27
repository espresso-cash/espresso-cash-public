import 'package:flutter/widgets.dart';
import 'package:intl/number_symbols_data.dart' show numberFormatSymbols;

String getDecimalSeparator(Locale locale) =>
    numberFormatSymbols[locale.languageCode]?.DECIMAL_SEP ?? '.';

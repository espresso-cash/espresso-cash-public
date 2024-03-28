import 'package:decimal/decimal.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository.dart';

extension ConversionRates on BuildContext {
  Decimal? watchConversionRate({
    required FiatCurrency to,
  }) =>
      watch<ConversionRatesRepository>().readRate(to: to);
}

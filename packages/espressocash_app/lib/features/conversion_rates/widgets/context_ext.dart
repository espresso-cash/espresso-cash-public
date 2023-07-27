import 'package:decimal/decimal.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/currency.dart';
import '../../../core/tokens/token.dart';
import '../data/repository.dart';

extension ConversionRates on BuildContext {
  Decimal? watchConversionRate({
    required Token from,
    required FiatCurrency to,
  }) =>
      watch<ConversionRatesRepository>()
          .readRate(CryptoCurrency(token: from), to: to);
}

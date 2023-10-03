// ignore_for_file: avoid-banned-imports

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../features/ramp/src/models/ramp_type.dart';
import '../../../features/ramp/src/screens/ramp_amount_screen.dart';
import '../../utils.dart';

final offRampAmountScreenStory = Story(
  name: 'Screens/OffRampAmountScreen',
  builder: (context) => RampAmountScreen(
    onSubmitted: ignore,
    minAmount: Decimal.fromInt(10),
    currency: Currency.usdc,
    type: context.knobs.options(
      label: 'Type',
      initial: RampType.onRamp,
      options: RampType.values.toOptions(),
    ),
    calculateEquivalent: (amount) => Future.delayed(
      const Duration(seconds: 1),
      () => Either.right(
        FiatAmount(
          value:
              Currency.usd.decimalToInt(amount.decimal * Decimal.parse('0.95')),
          fiatCurrency: Currency.usd,
        ),
      ),
    ),
  ),
);

// ignore_for_file: avoid-banned-imports

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../features/ramp/src/screens/off_ramp_amount_screen.dart';

final offRampAmountScreenStory = Story(
  name: 'Screens/OffRampAmountScreen',
  builder: (context) => OffRampAmountScreen(
    onSubmitted: ignore,
    minAmount: Decimal.fromInt(10),
    currency: Currency.usdc,
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

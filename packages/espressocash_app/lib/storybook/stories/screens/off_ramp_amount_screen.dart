import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../features/currency/models/amount.dart';
import '../../../features/currency/models/currency.dart';
import '../../../features/ramp/models/ramp_type.dart';
import '../../../features/ramp/screens/ramp_amount_screen.dart';
import '../../../features/ramp_partner/models/ramp_partner.dart';
import '../../utils.dart';

final offRampAmountScreenStory = Story(
  name: 'Screens/OffRampAmountScreen',
  builder: (context) => RampAmountScreen(
    partner: context.knobs.options(
      label: 'Partner',
      initial: RampPartner.kado,
      options: RampPartner.values.toOptions(),
    ),
    onSubmitted: ignore,
    minAmount: Decimal.fromInt(10),
    currency: Currency.usdc,
    type: context.knobs.options(
      label: 'Type',
      initial: RampType.onRamp,
      options: RampType.values.toOptions(),
    ),
    calculateEquivalent: (amount) async => Future.delayed(
      Duration.zero,
      () => Either.right(
        (
          amount: FiatAmount(
            value: Currency.usd
                .decimalToInt(amount.decimal * Decimal.parse('0.95')),
            fiatCurrency: Currency.usd,
          ),
          rate: '1 USDC = 1234 USD'
        ),
      ),
    ),
    calculateFee: (amount) => CryptoAmount(
      value: Currency.usdc.decimalToInt(amount.decimal * Decimal.parse('0.05')),
      cryptoCurrency: Currency.usdc,
    ),
  ),
);

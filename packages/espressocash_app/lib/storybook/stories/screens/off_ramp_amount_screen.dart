import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../features/currency/models/amount.dart';
import '../../../features/currency/models/currency.dart';
import '../../../features/ramp/screens/ramp_amount_screen.dart';
import '../../../features/ramp_partner/models/ramp_partner.dart';
import '../../../features/ramp_partner/models/ramp_type.dart';
import '../../utils.dart';

final offRampAmountScreenStory = Story(
  name: 'Screens/OffRampAmountScreen',
  builder:
      (context) => RampAmountScreen(
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
        calculateEquivalent:
            (amount) async => Future.delayed(
              Duration.zero,
              () => Either.right(
                FiatAmount(
                  value: Currency.usd.decimalToInt(amount.decimal * Decimal.parse('0.95')),
                  fiatCurrency: Currency.usd,
                ),
              ),
            ),
        calculateFee:
            (amount) => Future.delayed(
              Duration.zero,
              () => Either.right((
                partnerFee: '1 USDC',
                ourFee: '1 USDC',
                totalFee: FiatAmount(
                  value: Currency.usd.decimalToInt(amount.decimal * Decimal.parse('0.05')),
                  fiatCurrency: Currency.usd,
                ),
                extraFee: null,
              )),
            ),
        exchangeRate: null,
        receiveCurrency: null,
        initialAmount: null,
      ),
);

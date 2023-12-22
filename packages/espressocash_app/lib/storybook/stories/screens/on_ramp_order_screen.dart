import 'package:decimal/decimal.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../data/db/db.dart';
import '../../../features/ramp/models/ramp_partner.dart';
import '../../../features/ramp/screens/on_ramp_order_screen.dart';
import '../../utils.dart';

final onRampOrderScreenStory = Story(
  name: 'Screens/OnRampOrderScreen',
  builder: (context) => OnRampOrderScreenContent(
    order: (
      id: 'ORDER_ID',
      created: DateTime.now(),
      amount: const CryptoAmount(
        value: 10000000,
        cryptoCurrency: Currency.usdc,
      ),
      receiveAmount: null,
      partner: RampPartner.scalex,
      status: context.knobs.options(
        label: 'Status',
        initial: OnRampOrderStatus.waitingForPartner,
        options: OnRampOrderStatus.values.toOptions(),
      ),
      partnerOrderId: 'PARTNER_ORDER_ID',
      manualDeposit: (
        bankAccount: 'BANK_ACCOUNT_12345',
        bankName: 'BANK_NAME',
        transferAmount: Amount.fromDecimal(
          value: Decimal.parse('100000'),
          currency: Currency.ngn,
        ) as FiatAmount,
        transferExpiryDate: DateTime.now().add(const Duration(minutes: 30))
      ),
    ),
  ),
);

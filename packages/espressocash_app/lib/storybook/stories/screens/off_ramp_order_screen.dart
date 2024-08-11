import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../data/db/db.dart';
import '../../../features/currency/models/amount.dart';
import '../../../features/currency/models/currency.dart';
import '../../../features/ramp/screens/off_ramp_order_screen.dart';
import '../../../features/ramp_partner/models/ramp_partner.dart';
import '../../utils.dart';

final offRampOrderScreenStory = Story(
  name: 'Screens/OffRampOrderScreen',
  builder: (context) => OffRampOrderScreenContent(
    order: (
      id: 'ORDER_ID',
      created: DateTime.now(),
      status: context.knobs.options(
        label: 'Status',
        initial: OffRampOrderStatus.depositTxRequired,
        options: OffRampOrderStatus.values.toOptions(),
      ),
      amount: const CryptoAmount(
        value: 10000000,
        cryptoCurrency: Currency.usdc,
      ),
      receiveAmount: null,
      partner: context.knobs.options(
        label: 'Partner',
        initial: RampPartner.scalex,
        options: RampPartner.values.toOptions(),
      ),
      resolved: null,
      partnerOrderId: 'PARTNER_ORDER_ID',
      depositAddress: null,
      fee: const CryptoAmount(
        value: 10000000,
        cryptoCurrency: Currency.usdc,
      ),
      withdrawAnchorAccount: null,
      withdrawUrl: null,
      authToken: null,
      moreInfoUrl: 'https://example.com',
      referenceNumber: '11111111',
      bridgeAmount: null,
    ),
  ),
);

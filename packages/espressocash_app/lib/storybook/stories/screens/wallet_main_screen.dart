import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../features/wallet_flow/widgets/wallet_tab_view.dart';
import '../../utils/app_wrapper.dart';

final walletMainScreen = Story(
  name: 'Screens/WalletMainScreen',
  wrapperBuilder: appWrapper,
  builder: (context) => DefaultTabController(
    length: 2,
    child: WalletMainScreen(
      onScan: () {},
      onAmountChanged: (_) {},
      onRequest: () {},
      onPay: () {},
      amount: const FiatAmount(value: 0, fiatCurrency: Currency.usd),
      token: Currency.usdc.token,
    ),
  ),
);

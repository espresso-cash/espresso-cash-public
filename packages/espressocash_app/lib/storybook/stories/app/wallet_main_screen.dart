import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

import '../../../core/amount.dart';
import '../../../core/currency.dart';
import '../../../features/wallet_flow/screens/wallet_main_screen.dart';
import '../../../ui/theme.dart';
import 'app_wrapper.dart';

final appWalletMainScreen = Story(
  name: 'App/WalletMainScreen',
  builder: (context) => AppWrapper(
    child: CpTheme.dark(
      child: DefaultTabController(
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
    ),
  ),
);

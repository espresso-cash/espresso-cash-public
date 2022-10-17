import 'package:cryptoplease/app/screens/authenticated/wallet_flow/wallet_main_screen.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/storybook/stories/app/app_wrapper.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

final appWalletMainScreen = Story(
  name: 'app/WalletMainScreen',
  builder: (context) => AppWrapper(
    child: CpTheme.dark(
      child: WalletMainScreen(
        onScan: () {},
        onAmountChanged: (_) {},
        onRequest: () {},
        onPay: () {},
        amount: const CryptoAmount(value: 0, currency: Currency.usdc),
      ),
    ),
  ),
);

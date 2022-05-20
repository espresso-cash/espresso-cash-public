import 'package:cryptoplease/bl/amount.dart';
import 'package:cryptoplease/bl/currency.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/fungible_token/confirm_screen/new_solana_pay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeTabsScreen extends StatefulWidget {
  const HomeTabsScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  int _currentPage = 0;

  void _onBottomNavigatorItemTap(int page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) => const SolanaPayScreen(
        address: 'JBUmKafR4MoMsavwiRrwwhDa57Mu7vJ5EkAfJWB4rYgw',
        cryptoAmount: CryptoAmount(
          value: 100000,
          currency: CryptoCurrency(token: Token.sol),
        ),
        fiatAmount: FiatAmount(
          value: 1000,
          currency: Currency.usd,
        ),
      );
}

class _Page {
  const _Page({
    required this.widget,
    required this.overlayStyle,
  });

  final Widget widget;
  final SystemUiOverlayStyle overlayStyle;
}

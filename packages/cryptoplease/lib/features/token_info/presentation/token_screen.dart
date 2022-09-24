import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/token_info/bl/token_info_bloc.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WalletRouterScreen extends StatefulWidget {
  const WalletRouterScreen({super.key});

  @override
  State<WalletRouterScreen> createState() => _WalletRouterScreenState();
}

class _WalletRouterScreenState extends State<WalletRouterScreen> {
  final routerKey = GlobalKey<AutoRouterState>();

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}

class TokenScreen extends StatefulWidget {
  const TokenScreen({super.key, required this.token});

  final Token token;

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TokenInfoBloc>().add(FetchRequested(token: widget.token));
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
              child: CpContentPadding(
                child: Column(
                  children: [
                    _Header(widget.token),
                    const _TokenChart(),
                    const _Buttons(),
                    const _TokenInfo(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header(this.token);
  final Token token;

  @override
  Widget build(BuildContext context) {
    // token
    final test = context.readConversionRate(
      from: token,
      to: Currency.usd,
    );

    return Column(
      children: [
        TokenIcon(token: token, size: 60),
        Text(
          token.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 26,
          ),
        ),
        Text(test.toString())
      ],
    );
  }
}

class _TokenChart extends StatelessWidget {
  const _TokenChart();

  @override
  Widget build(BuildContext context) => const SizedBox(
        height: 200,
        child: Placeholder(),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CpButton(text: 'Buy', onPressed: () {}),
          CpButton(text: 'Sell', onPressed: () {}),
          CpButton(text: 'Send', onPressed: () {})
        ],
      );
}

class _TokenInfo extends StatelessWidget {
  const _TokenInfo();

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'About Solana',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
          Text(
            'Solana is an open source project implementing a new, high-performance, permissionless blockchain. The Solana Foundation is based in Geneva, Switzerland and maintains the open source project.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          )
        ],
      );
}

import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../activities/services/tx_updater.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../balances/data/repository.dart';
import '../../currency/models/amount.dart';
import '../../ramp/widgets/ramp_buttons.dart';
import '../../tokens/token.dart';
import '../widgets/home_add_cash.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel.dart';
import '../widgets/investment_header.dart';
import '../widgets/portfolio_widget.dart';
import '../widgets/refresh_balance_wrapper.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.onSendMoneyPressed,
    required this.onTransactionsPressed,
  });

  final VoidCallback onSendMoneyPressed;
  final VoidCallback onTransactionsPressed;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: ValueStreamBuilder<bool>(
          create: () => (
            sl<TokenBalancesRepository>()
                .watchUserTokens()
                .map((it) => it.isEmpty),
            true
          ),
          builder: (context, isEmpty) => isEmpty
              ? const HomeAddCashContent()
              : _MainContent(
                  onSendMoneyPressed: onSendMoneyPressed,
                  onTransactionsPressed: onTransactionsPressed,
                ),
        ),
      );
}

class _MainContent extends StatelessWidget {
  const _MainContent({
    required this.onSendMoneyPressed,
    required this.onTransactionsPressed,
  });

  final VoidCallback onSendMoneyPressed;
  final VoidCallback onTransactionsPressed;

  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, onRefresh) => RefreshIndicator(
          displacement: 80,
          onRefresh: () => Future.wait([
            onRefresh(),
            sl<TxUpdater>().call(),
          ]),
          color: CpColors.primaryColor,
          backgroundColor: Colors.white,
          child: Scaffold(
            backgroundColor: CpColors.darkGoldBackgroundColor,
            appBar: const HomeScaffoldAppBar(),
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        CpColors.darkGoldBackgroundColor,
                        CpColors.dashboardBackgroundColor,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.49, 0.51],
                    ),
                  ),
                ),
                _HomeScrollableRegion(
                  onSendMoneyPressed: onSendMoneyPressed,
                  onTransactionsPressed: onTransactionsPressed,
                ),
              ],
            ),
          ),
        ),
      );
}

class _HomeScrollableRegion extends StatelessWidget {
  const _HomeScrollableRegion({
    required this.onSendMoneyPressed,
    required this.onTransactionsPressed,
  });

  final VoidCallback onSendMoneyPressed;
  final VoidCallback onTransactionsPressed;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(31),
          topRight: Radius.circular(31),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 200,
                child: Container(
                  height: 300,
                  width: MediaQuery.sizeOf(context).width,
                  color: CpColors.dashboardBackgroundColor,
                ),
              ),
              Column(
                children: [
                  const InvestmentHeader(),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: CpColors.dashboardBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(31),
                        topRight: Radius.circular(31),
                      ),
                    ),
                    child: _Buttons(
                      onSendMoneyPressed: onSendMoneyPressed,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 28,
                      bottom: 18,
                    ),
                    color: CpColors.dashboardBackgroundColor,
                    child: const Divider(
                      color: CpColors.homeDividerColor,
                      thickness: 1.0,
                      height: 1.0,
                    ),
                  ),
                  ValueStreamBuilder<IList<CryptoAmount>>(
                    create: () => (
                      sl<TokenBalancesRepository>().watchTokenBalances(
                        ignoreTokens: [Token.usdc],
                      ),
                      const IListConst([])
                    ),
                    builder: (context, tokens) => tokens.isNotEmpty
                        ? const SizedBox.shrink()
                        : HomeCarouselWidget(
                            onSendMoneyPressed: onSendMoneyPressed,
                          ),
                  ),
                  const PortfolioWidget(),
                  RecentActivityWidget(
                    onSendMoneyPressed: onSendMoneyPressed,
                    onTransactionsPressed: onTransactionsPressed,
                  ),
                  SizedBox(
                    height: max(
                      0,
                      MediaQuery.paddingOf(context).bottom -
                          cpNavigationBarheight +
                          16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.onSendMoneyPressed});

  final VoidCallback onSendMoneyPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          left: 18,
          top: 32,
          right: 18,
          bottom: 8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Text(
                context.l10n.investmentHeaderButtonsTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  letterSpacing: 0.23,
                ),
              ),
            ),
            const SizedBox(height: 19),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: PayOrRequestButton(
                    voidCallback: onSendMoneyPressed,
                  ),
                ),
                const Expanded(
                  child: AddCashButton(size: CpButtonSize.wide),
                ),
                const Expanded(
                  child: CashOutButton(size: CpButtonSize.wide),
                ),
              ],
            ),
          ],
        ),
      );
}

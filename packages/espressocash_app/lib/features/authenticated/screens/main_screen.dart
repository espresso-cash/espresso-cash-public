import 'dart:math';

import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/colors.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../activities/services/tx_updater.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../conversion_rates/services/watch_user_fiat_balance.dart';
import '../widgets/home_add_cash.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel.dart';
import '../widgets/investment_header.dart';
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
          create: () =>
              sl<WatchUserFiatBalance>().call().map((it) => it.isZero),
          builder: (context, isZeroAmount) => isZeroAmount
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
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CpColors.darkGoldBackgroundColor,
              CpColors.dashboardBackgroundColor,
            ],
            stops: [0.49, 0.51],
          ),
        ),
        child: RefreshBalancesWrapper(
          builder: (context, onRefresh) => RefreshIndicator(
            displacement: 80,
            onRefresh: () => Future.wait([
              onRefresh(),
              sl<TxUpdater>().call(),
            ]),
            color: CpColors.primaryColor,
            backgroundColor: Colors.white,
            child: CustomScrollView(
              slivers: [
                const HomeAppBar(
                  backgroundColor: CpColors.darkGoldBackgroundColor,
                ),
                SliverToBoxAdapter(
                  child: InvestmentHeader(
                    onSendMoneyPressed: onSendMoneyPressed,
                  ),
                ),
                SliverToBoxAdapter(
                  child: HomeCarouselWidget(
                    onSendMoneyPressed: onSendMoneyPressed,
                  ),
                ),
                SliverToBoxAdapter(
                  child: RecentActivityWidget(
                    onSendMoneyPressed: onSendMoneyPressed,
                    onTransactionsPressed: onTransactionsPressed,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: max(
                      0,
                      MediaQuery.paddingOf(context).bottom -
                          cpNavigationBarheight +
                          16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

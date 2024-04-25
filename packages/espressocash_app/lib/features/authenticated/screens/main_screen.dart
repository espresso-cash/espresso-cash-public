import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../ui/colors.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/page_fade_wrapper.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../activities/services/tx_updater.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../balances/widgets/refresh_balance_wrapper.dart';
import '../../conversion_rates/services/watch_user_fiat_balance.dart';
import '../../currency/models/amount.dart';
import '../widgets/home_add_cash.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel.dart';
import '../widgets/investment_header.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: ValueStreamBuilder<bool>(
          create: () =>
              sl<WatchUserFiatBalance>().call().map((it) => it.isZero),
          builder: (context, isZeroAmount) =>
              isZeroAmount ? const HomeAddCashContent() : const _MainContent(),
        ),
      );
}

class _MainContent extends StatelessWidget {
  const _MainContent();

  @override
  Widget build(BuildContext context) => PageFadeWrapper(
        child: Container(
          padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CpColors.darkSplashBackgroundColor,
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
                  const HomeAppBar(),
                  const SliverToBoxAdapter(child: InvestmentHeader()),
                  const SliverToBoxAdapter(child: HomeCarouselWidget()),
                  const SliverToBoxAdapter(child: RecentActivityWidget()),
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
        ),
      );
}

extension on Amount {
  bool get isZero => decimal == Decimal.zero;
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: MainScreen());
}

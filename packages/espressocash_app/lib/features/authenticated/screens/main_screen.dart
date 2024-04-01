import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../routing.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/page_fade_wrapper.dart';
import '../../../ui/theme.dart';
import '../../activities/services/tx_updater.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../balances/widgets/refresh_balance_wrapper.dart';
import '../../currency/currency.dart';
import '../../profile/screens/profile_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import '../widgets/home_carousel.dart';
import '../widgets/investment_header.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> _handleScanPressed() =>
      context.launchQrScannerFlow(cryptoCurrency: Currency.usdc);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: PageFadeWrapper(
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
                    SliverAppBar(
                      leading: Center(
                        child: CpIconButton(
                          icon: Assets.icons.qrScanner.svg(),
                          variant: CpIconButtonVariant.black,
                          onPressed: _handleScanPressed,
                        ),
                      ),
                      shape: const Border(),
                      title: Center(
                        child: Assets.images.logo.image(height: 32),
                      ),
                      pinned: true,
                      snap: false,
                      floating: false,
                      elevation: 0,
                      backgroundColor: CpColors.darkBackground,
                      actions: [
                        CpIconButton(
                          icon: Assets.icons.settingsButtonIcon
                              .svg(color: Colors.white),
                          variant: CpIconButtonVariant.black,
                          onPressed: () => const ProfileRoute().go(context),
                        ),
                        const SizedBox(width: 12),
                      ],
                      toolbarHeight: kToolbarHeight + 12,
                    ),
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
        ),
      );
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: MainScreen());
}

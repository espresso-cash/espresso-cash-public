import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/currency.dart';
import '../../../core/presentation/page_fade_wrapper.dart';
import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/theme.dart';
import '../../activities/widgets/extensions.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../balances/widgets/refresh_balance_wrapper.dart';
import '../../onboarding/onboarding.dart';
import '../../profile/screens/profile_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import '../widgets/home_carousel.dart';
import '../widgets/investing_widget.dart';
import '../widgets/investment_header.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static const route = MainRoute.new;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Future<void> _onQrScanner() =>
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
                  context.refreshTransactions(),
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
                          onPressed: _onQrScanner,
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
                          onPressed: () =>
                              context.router.push(ProfileScreen.route()),
                        ),
                        const SizedBox(width: 12),
                      ],
                      toolbarHeight: kToolbarHeight + 12,
                    ),
                    const SliverToBoxAdapter(child: InvestmentHeader()),
                    const SliverToBoxAdapter(child: OnboardingNotice()),
                    const SliverToBoxAdapter(child: HomeCarouselWidget()),
                    const SliverToBoxAdapter(child: RecentActivityWidget()),
                    const SliverToBoxAdapter(child: InvestingWidget()),
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

import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/arrow.dart';
import '../../../ui/bullet_item.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/page_fade_wrapper.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../accounts/models/account.dart';
import '../../activities/services/tx_updater.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../balances/widgets/refresh_balance_wrapper.dart';
import '../../conversion_rates/services/watch_user_fiat_balance.dart';
import '../../currency/models/amount.dart';
import '../../currency/models/currency.dart';
import '../../profile/screens/profile_screen.dart';
import '../../qr_scanner/widgets/build_context_ext.dart';
import '../../ramp/models/ramp_type.dart';
import '../../ramp/widgets/ramp_buttons.dart';
import '../../wallet_flow/screens/wallet_screen.dart';
import '../widgets/home_carousel.dart';
import '../widgets/investment_header.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: ValueStreamBuilder<bool>(
          create: () =>
              sl<WatchUserFiatBalance>().call().map((it) => it.isZero),
          builder: (context, isZeroAmount) => isZeroAmount
              ? const _NoBalanceContent()
              : const _RegularContent(),
        ),
      );
}

class _RegularContent extends StatelessWidget {
  const _RegularContent();

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
                  const _AppBar(),
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

class _NoBalanceContent extends StatelessWidget {
  const _NoBalanceContent();

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: CpColors.yellowSplashBackgroundColor,
        child: RefreshBalancesWrapper(
          builder: (context, onRefresh) => RefreshIndicator(
            displacement: 80,
            onRefresh: () => Future.wait([
              onRefresh(),
              sl<TxUpdater>().call(),
            ]),
            color: CpColors.primaryColor,
            backgroundColor: Colors.white,
            child: const Stack(
              children: [
                _Background(),
                CustomScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  slivers: [
                    _AppBar(backgroundColor: Colors.transparent),
                    SliverFillRemaining(
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Spacer(flex: 2),
                            _NoticeContent(),
                            Spacer(),
                            _BottomBalance(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
}

class _NoticeContent extends StatelessWidget {
  const _NoticeContent();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.depositTitle.toUpperCase(),
              style: TextStyle(
                fontSize: 50.h,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              context.l10n.addCashNoticeSubtitle.toUpperCase(),
              style: TextStyle(
                fontSize: 22.h,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.25,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.h),
            CpBulletItemWidget(
              child: Text.rich(
                style: _bulletTextStyle,
                TextSpan(
                  text: context.l10n.addCash_noInflation1,
                  children: [
                    TextSpan(
                      text: context.l10n.addCash_noInflation2,
                      style: const TextStyle(color: CpColors.yellowColor),
                    ),
                    TextSpan(
                      text: context.l10n.addCash_noInflation3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            CpBulletItemWidget(
              child: Text(
                context.l10n.addCash_CashoutAnytime,
                style: _bulletTextStyle,
              ),
            ),
            const SizedBox(height: 8),
            CpBulletItemWidget(
              child: Text(
                context.l10n.addCash_sendReceiveMoney,
                style: _bulletTextStyle,
              ),
            ),
            SizedBox(height: 24.h),
            CpButton(
              text: context.l10n.ramp_btnAddCash,
              onPressed: () async {
                final data = await context.ensureProfileData(RampType.onRamp);
                if (context.mounted && data != null) {
                  context.launchOnRampFlow(
                    profile: data,
                    address:
                        context.read<MyAccount>().wallet.publicKey.toBase58(),
                  );
                }
              },
              width: double.infinity,
              size: CpButtonSize.big,
              trailing: Padding(
                padding: EdgeInsets.only(right: 8.h),
                child: const Arrow(),
              ),
            ),
            SizedBox(height: 24.h),
            Center(
              child: CpButton(
                text: context.l10n.addCashNoticeRequestBtn,
                onPressed: () =>
                    const WalletRoute(initialTab: WalletTab.request)
                        .go(context),
                width: 210.w,
                size: CpButtonSize.small,
              ),
            ),
          ],
        ),
      );
}

class _Background extends StatelessWidget {
  const _Background();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.sizeOf(context).height / 1.5,
        child: Stack(
          children: [
            Transform.rotate(
              angle: 0.2,
              child: Transform.translate(
                offset: const Offset(-30, -25),
                child: Assets.images.dollarBg.image(
                  fit: BoxFit.cover,
                  height: double.infinity,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 400,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    stops: [0.1, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00C8B57D),
                      CpColors.yellowSplashBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _BottomBalance extends StatelessWidget {
  const _BottomBalance();

  @override
  Widget build(BuildContext context) => DecoratedBox(
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(44),
              topRight: Radius.circular(44),
            ),
          ),
          color: CpColors.darkSplashBackgroundColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 40.h,
                bottom: 16.h,
              ),
              child: Column(
                children: [
                  Text(
                    context.l10n.cryptoCashBalance,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.23,
                    ),
                  ),
                  const BalanceAmount(),
                ],
              ),
            ),
          ),
        ),
      );
}

final _bulletTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 19.h,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.41,
);

extension on Amount {
  bool get isZero => decimal == Decimal.zero;
}

class _AppBar extends StatelessWidget {
  const _AppBar({this.backgroundColor = CpColors.darkBackground});

  final Color backgroundColor;

  @override
  Widget build(BuildContext context) => SliverAppBar(
        leading: Center(
          child: CpIconButton(
            icon: Assets.icons.qrScanner.svg(),
            variant: CpIconButtonVariant.black,
            onPressed: () =>
                context.launchQrScannerFlow(cryptoCurrency: Currency.usdc),
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
        backgroundColor: backgroundColor,
        actions: [
          CpIconButton(
            icon: Assets.icons.settingsButtonIcon.svg(color: Colors.white),
            variant: CpIconButtonVariant.black,
            onPressed: () => const ProfileRoute().go(context),
          ),
          const SizedBox(width: 12),
        ],
        toolbarHeight: kToolbarHeight + 12,
      );
}

class HomeRoute extends GoRouteData {
  const HomeRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      const NoTransitionPage(child: MainScreen());
}

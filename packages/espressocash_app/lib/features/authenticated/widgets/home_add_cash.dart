import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/arrow.dart';
import '../../../ui/bullet_item.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../accounts/models/account.dart';
import '../../activities/services/tx_updater.dart';
import '../../ramp/models/ramp_type.dart';
import '../../ramp/widgets/ramp_buttons.dart';
import 'balance_amount.dart';
import 'home_app_bar.dart';
import 'refresh_balance_wrapper.dart';

class HomeAddCashContent extends StatelessWidget {
  const HomeAddCashContent({super.key});

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
                    HomeAppBar(backgroundColor: Colors.transparent),
                    SliverFillRemaining(
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Spacer(flex: 3),
                            _NoticeContent(),
                            Spacer(flex: 2),
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
        padding: const EdgeInsets.symmetric(horizontal: 32),
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
                textAlign: TextAlign.left,
                TextSpan(
                  text: '${context.l10n.addCash_noInflation1}\n',
                  children: [
                    TextSpan(
                      text: context.l10n.addCash_noInflation2,
                    ),
                    TextSpan(
                      text: context.l10n.addCash_noInflation3,
                      style: const TextStyle(color: Color(0xffFFDA66)),
                    ),
                    TextSpan(
                      text: context.l10n.addCash_noInflation4,
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
            SizedBox(height: 28.h),
            CpButton(
              text: context.l10n.ramp_btnAddCash,
              onPressed: () async {
                final data = await context.ensureProfileData(RampType.onRamp);
                if (context.mounted && data != null) {
                  context.launchOnRampFlow(
                    profile: data,
                    address: sl<MyAccount>().address,
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
                bottom: 8.h,
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
  fontSize: 18.h,
  fontWeight: FontWeight.w700,
  letterSpacing: 0.41,
);

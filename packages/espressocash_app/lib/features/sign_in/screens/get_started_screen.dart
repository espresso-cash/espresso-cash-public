import 'package:dfunc/dfunc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/splash_screen.dart';
import '../../../ui/theme.dart';
import '../../dynamic_links/services/dynamic_links_notifier.dart';
import '../../link_payments/models/link_payment.dart';
import '../widgets/terms_disclaimer.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({
    super.key,
    required this.onSignInPressed,
    required this.onLocalPressed,
  });

  final VoidCallback onSignInPressed;
  final VoidCallback onLocalPressed;

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  late final Future<void> _imagesCache;

  @override
  void initState() {
    super.initState();

    _imagesCache = Future(
      () => Future.wait([
        precacheImage(Assets.images.logo.provider(), context),
        precacheImage(Assets.images.dollarBg.provider(), context),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _imagesCache,
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? CpTheme.dark(
                child: Scaffold(
                  backgroundColor: CpColors.yellowSplashBackgroundColor,
                  body: Stack(
                    children: [
                      Align(
                        child: Assets.images.dollarBg.image(
                          fit: BoxFit.fitHeight,
                          height: double.infinity,
                        ),
                      ),
                      SafeArea(
                        minimum: EdgeInsets.only(top: 70.h),
                        child: LayoutBuilder(
                          builder: (context, constraints) =>
                              SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: constraints.copyWith(
                                minHeight: constraints.maxHeight,
                                maxHeight: double.infinity,
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Expanded(
                                      child: Center(child: SplashLogo()),
                                    ),
                                    Column(
                                      children: [
                                        const _Body(),
                                        24.verticalSpace,
                                        _Footer(
                                          onSignInPressed:
                                              widget.onSignInPressed,
                                          onLocalPressed: widget.onLocalPressed,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SplashScreen(),
      );
}

class _Footer extends StatelessWidget {
  const _Footer({required this.onSignInPressed, required this.onLocalPressed});

  final VoidCallback onSignInPressed;
  final VoidCallback onLocalPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 44.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            8.verticalSpace,
            _CreateLocalWalletButton(onPressed: onLocalPressed),
            19.verticalSpace,
            Text.rich(
              key: keyUseExistingWalletButton,
              TextSpan(
                text: context.l10n.signIn1,
                children: [
                  TextSpan(
                    text: context.l10n.signIn2,
                    recognizer: TapGestureRecognizer()..onTap = onSignInPressed,
                    style: const TextStyle(color: CpColors.yellowColor),
                  ),
                ],
              ),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
            ),
            67.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: const TermsDisclaimer(),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      );
}

class _CreateLocalWalletButton extends StatelessWidget {
  const _CreateLocalWalletButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => CpButton(
        key: keyCreateWalletButton,
        text: context.l10n.signUp,
        width: double.infinity,
        onPressed: onPressed,
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: sl<DynamicLinksNotifier>(),
        builder: (context, _) => Padding(
          padding: EdgeInsets.only(left: 30.w, right: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: sl<DynamicLinksNotifier>().link.let(_parseUri)
                ? [
                    Text(
                      context.l10n.onboardingWithPaymentTitle.toUpperCase(),
                      style: TextStyle(
                        fontSize: 46.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.25,
                      ),
                    ),
                    Text(
                      context.l10n.onboardingWithPaymentSubtitle.toUpperCase(),
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ]
                : [
                    Text(
                      context.l10n.onboardingIntro.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 46.sp,
                        height: 0.9,
                      ),
                    ),
                  ],
          ),
        ),
      );
}

const keyCreateWalletButton = Key('createWalletButton');
const keyUseExistingWalletButton = Key('useExistingWalletButton');

bool _parseUri(Uri? link) {
  if (link == null) return false;

  return LinkPayment.tryParse(link) != null;
}

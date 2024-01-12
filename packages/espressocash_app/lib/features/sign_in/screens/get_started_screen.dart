import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../services/sign_in_bloc.dart';
import '../widgets/terms_disclaimer.dart';

@RoutePage()
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({
    super.key,
    required this.isSaga,
    required this.onSignInPressed,
  });

  static const route = GetStartedRoute.new;

  final bool isSaga;
  final VoidCallback onSignInPressed;

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with TickerProviderStateMixin {
  late final AnimationController slideAnimationController;
  late final Animation<Offset> slideOffsetAnimation;
  late final AnimationController fadeAnimationController;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    slideAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    slideOffsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: slideAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: fadeAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.yellowSplashBackgroundColor,
          body: FadeTransition(
            opacity: fadeAnimationController,
            child: Stack(
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
                    builder: (context, constraints) => SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: constraints.copyWith(
                          minHeight: constraints.maxHeight,
                          maxHeight: double.infinity,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: SlideTransition(
                                  position: slideOffsetAnimation,
                                  child: const _Logo(),
                                ),
                              ),
                              const _Body(),
                              24.verticalSpace,
                              _Footer(
                                isSaga: widget.isSaga,
                                onSignInPressed: widget.onSignInPressed,
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
        ),
      );

  @override
  void dispose() {
    slideAnimationController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) =>
      Assets.images.logo.image(width: 309.r, height: 66.r);
}

class _Footer extends StatelessWidget {
  const _Footer({required this.isSaga, required this.onSignInPressed});

  final bool isSaga;
  final VoidCallback onSignInPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 44.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            8.verticalSpace,
            if (isSaga) ...[
              const _SignInWithSagaButton(),
              37.verticalSpace,
            ] else ...[
              const _CreateLocalWalletButton(),
              19.verticalSpace,
              Text.rich(
                key: keyUseExistingWalletButton,
                TextSpan(
                  text: context.l10n.signIn1,
                  children: [
                    TextSpan(
                      text: context.l10n.signIn2,
                      recognizer: TapGestureRecognizer()
                        ..onTap = onSignInPressed,
                      style: const TextStyle(color: CpColors.yellowColor),
                    ),
                  ],
                ),
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15.sp),
              ),
            ],
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
  const _CreateLocalWalletButton();

  @override
  Widget build(BuildContext context) => CpButton(
        key: keyCreateWalletButton,
        text: context.l10n.signUp,
        width: double.infinity,
        onPressed: () => context
            .read<SignInBloc>()
            .add(const SignInEvent.newLocalWalletRequested()),
      );
}

class _SignInWithSagaButton extends StatefulWidget {
  const _SignInWithSagaButton();

  @override
  State<_SignInWithSagaButton> createState() => _SignInWithSagaButtonState();
}

class _SignInWithSagaButtonState extends State<_SignInWithSagaButton> {
  Future<void> _handlePressed() async {
    final hasPermission = await sl<SeedVault>().checkPermission();
    if (!mounted) return;
    if (!hasPermission) return;

    context
        .read<SignInBloc>()
        .add(const SignInEvent.existingSagaWalletRequested());
  }

  @override
  Widget build(BuildContext context) => CpButton(
        key: keyCreateWalletButton,
        text: context.l10n.signInWithSaga,
        width: double.infinity,
        onPressed: _handlePressed,
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 30.w, right: 25.w),
        // TODO(KB): Check if needed
        // ignore: avoid-single-child-column-or-row
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
      );
}

const keyCreateWalletButton = Key('createWalletButton');
const keyUseExistingWalletButton = Key('useExistingWalletButton');

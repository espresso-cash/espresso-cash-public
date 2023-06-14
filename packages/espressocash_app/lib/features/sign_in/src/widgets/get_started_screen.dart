import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/bullet_item.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../bl/sign_in_bloc.dart';
import 'components/terms_disclaimer.dart';
import 'sign_in_flow_screen.dart';

@RoutePage()
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key, required this.isSaga});

  final bool isSaga;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkSplashBackgroundColor,
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Assets.icons.logoDark.svg(
                  alignment: Alignment.bottomCenter,
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
                          children: [
                            const _Header(),
                            32.verticalSpace,
                            const _Body(),
                            Expanded(child: _Footer(isSaga: isSaga)),
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
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Assets.images.logo.image(width: 201.r, height: 43.r),
        ],
      );
}

class _Footer extends StatelessWidget {
  const _Footer({required this.isSaga});

  final bool isSaga;

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
                        ..onTap = () => context.signInRouter.onSignIn(),
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
  Future<void> _onPressed() async {
    final hasPermission = await sl<SeedVault>().checkPermission();
    if (!mounted || !hasPermission) return;

    context
        .read<SignInBloc>()
        .add(const SignInEvent.existingSagaWalletRequested());
  }

  @override
  Widget build(BuildContext context) => CpButton(
        key: keyCreateWalletButton,
        text: context.l10n.signInWithSaga,
        width: double.infinity,
        onPressed: _onPressed,
      );
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 30.w, right: 25.w),
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
            128.verticalSpace,
            CpBulletItemWidget(text: context.l10n.onboardingBullet),
          ],
        ),
      );
}

const keyCreateWalletButton = Key('createWalletButton');
const keyUseExistingWalletButton = Key('useExistingWalletButton');

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                top: false,
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
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Assets.images.logo.image(height: 110, width: 210),
          ],
        ),
      );
}

class _Footer extends StatelessWidget {
  const _Footer({required this.isSaga});

  final bool isSaga;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 8),
            if (isSaga)
              const _SignInWithSagaButton()
            else ...[
              const _CreateLocalWalletButton(),
              const SizedBox(height: 16),
              Text.rich(
                key: keyUseExistingWalletButton,
                TextSpan(
                  text: context.l10n.signIn1,
                  children: [
                    TextSpan(
                      text: context.l10n.signIn2,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.signInRouter.onSignIn(),
                      style: const TextStyle(
                        color: CpColors.yellowColor,
                      ),
                    ),
                  ],
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ],
            const SizedBox(height: 34),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TermsDisclaimer(),
            ),
            const SizedBox(height: 16),
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              context.l10n.onboardingIntro.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 45,
                height: 0.9,
              ),
            ),
            const SizedBox(height: 8),
            CpBulletItemWidget(text: context.l10n.onboardingBullet),
          ],
        ),
      );
}

const keyCreateWalletButton = Key('createWalletButton');
const keyUseExistingWalletButton = Key('useExistingWalletButton');

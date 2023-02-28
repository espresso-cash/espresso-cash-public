import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana_seed_vault/solana_seed_vault.dart';

import '../../../../core/extensions.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/bullet_item.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/theme.dart';
import '../bl/sign_in_bloc.dart';
import 'components/terms_disclaimer.dart';
import 'sign_in_flow_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: const Color(0xff2D2B2C),
          body: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Assets.icons.logoDark.svg(
                  alignment: Alignment.bottomCenter,
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: constraints.copyWith(
                      minHeight: constraints.maxHeight,
                      maxHeight: double.infinity,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        children: const [
                          _Header(),
                          _Body(),
                          Expanded(child: _Footer()),
                        ],
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
  const _Header({Key? key}) : super(key: key);

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

class _Footer extends StatefulWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  State<_Footer> createState() => _FooterState();
}

class _FooterState extends State<_Footer> {
  Future<void> _onCreateWallet() async {
    final hasSeedVault = await context.read<SeedVault>().isReady();
    if (!mounted) return;

    final SignInEvent signInEvent;
    if (hasSeedVault) {
      signInEvent = const SignInEvent.newSagaWalletRequested();
    } else {
      signInEvent = const SignInEvent.phraseRequested();
    }

    context.read<SignInBloc>().add(signInEvent);
  }

  Future<void> _onExistingWallet() async {
    final hasSeedVault = await context.read<SeedVault>().isReady();
    if (!mounted) return;

    if (hasSeedVault) {
      context
          .read<SignInBloc>()
          .add(const SignInEvent.existingSagaWalletRequested());
    } else {
      context.signInRouter.onSignIn();
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CpButton(
              key: keyCreateWalletButton,
              text: context.l10n.signUp,
              width: double.infinity,
              onPressed: _onCreateWallet,
            ),
            const SizedBox(height: 16),
            Text.rich(
              key: keyUseExistingWalletButton,
              TextSpan(
                text: context.l10n.signIn1,
                children: [
                  TextSpan(
                    text: context.l10n.signIn2,
                    recognizer: TapGestureRecognizer()
                      ..onTap = _onExistingWallet,
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
            const SizedBox(height: 42),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TermsDisclaimer(),
            ),
            const SizedBox(height: 22),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
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

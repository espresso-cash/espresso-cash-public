import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/bullet_item.dart';
import '../../../ui/button.dart';
import '../../../ui/theme.dart';
import 'components/terms_disclaimer.dart';
import 'onboarding_flow_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
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
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          children: [
            Assets.images.logo.image(height: 195, width: 250),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                context.l10n.getStarted,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  letterSpacing: .25,
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
}

class _Footer extends StatelessWidget {
  const _Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CpButton(
              key: keyCreateWalletButton,
              text: context.l10n.signUp,
              width: double.infinity,
              onPressed: () => context.onboardingRouter.onSignUp(),
            ),
            const SizedBox(height: 24),
            CpButton(
              key: keyUseExistingWalletButton,
              text: context.l10n.signIn,
              width: double.infinity,
              variant: CpButtonVariant.light,
              onPressed: () => context.onboardingRouter.onSignIn(),
            ),
            const SizedBox(height: 24),
            const TermsDisclaimer(),
            const SizedBox(height: 24),
          ],
        ),
      );
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            CpBulletItemWidget(text: context.l10n.startSendingAndReceiving),
            const SizedBox(height: 24),
            CpBulletItemWidget(text: context.l10n.fastOnboarding),
            const SizedBox(height: 24),
            CpBulletItemWidget(text: context.l10n.supportAllDay),
          ],
        ),
      );
}

const keyCreateWalletButton = Key('createWalletButton');
const keyUseExistingWalletButton = Key('useExistingWalletButton');

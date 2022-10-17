import 'package:cryptoplease/features/onboarding/presentation/sign_up/components/terms_disclaimer.dart';
import 'package:cryptoplease/features/onboarding/presentation/sign_up/sign_up_flow_screen.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/bullet_item.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: DecoratedBox(
            decoration: const BoxDecoration(color: CpColors.primaryColor),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Assets.icons.logoDark
                      .svg(alignment: Alignment.bottomCenter),
                ),
                SafeArea(
                  child: LayoutBuilder(
                    builder: (context, constraints) => SingleChildScrollView(
                      physics: const RangeMaintainingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            children: const [
                              _Header(),
                              Expanded(child: _Body()),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: _Footer(),
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
                style: Theme.of(context).textTheme.headline2?.copyWith(
                      fontSize: 28,
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
              onPressed: () => context.read<SignUpRouter>().onSignUp(),
            ),
            const SizedBox(height: 24),
            CpButton(
              key: keyUseExistingWalletButton,
              text: context.l10n.signIn,
              width: double.infinity,
              variant: CpButtonVariant.light,
              onPressed: () => context.read<SignUpRouter>().onSignIn(),
            ),
            const SizedBox(height: 24),
            const TermsDisclaimer(),
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

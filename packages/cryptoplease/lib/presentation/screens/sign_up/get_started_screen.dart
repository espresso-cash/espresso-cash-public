import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window_header.dart';
import 'package:cryptoplease/presentation/screens/sign_up/elements/terms_disclaimer.dart';
import 'package:cryptoplease/presentation/screens/sign_up/sign_up_flow_screen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: CpBackgroundGradient(
            child: SafeArea(
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
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: DecoratedWindowHeader(
          hasLogo: true,
          title: context.l10n.getStarted,
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
        padding: const EdgeInsets.all(24),
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

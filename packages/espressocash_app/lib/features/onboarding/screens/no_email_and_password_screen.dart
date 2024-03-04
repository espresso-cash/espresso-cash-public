import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/info_widget.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/theme.dart';
import 'view_recovery_phrase_screen.dart';

class NoEmailAndPasswordScreen extends StatelessWidget {
  const NoEmailAndPasswordScreen({super.key, required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.iUnderstand,
              onPressed: onDone,
            ),
            children: [
              const CpAppBar(leading: CpBackButton()),
              const OnboardingLogo(),
              OnboardingPadding(
                child: CpInfoWidget(
                  message: Text(context.l10n.noEmailInCryptoInfo),
                  variant: CpInfoVariant.black,
                ),
              ),
              const SizedBox(height: 38),
              OnboardingDescription(
                text: context.l10n.noEmailInCryptoParagraph,
              ),
            ],
          ),
        ),
      );
}

class OnboardingNoPasswordRoute extends GoRouteData {
  const OnboardingNoPasswordRoute({required this.finishPath});

  final String finishPath;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      NoEmailAndPasswordScreen(
        onDone: () => OnboardingRecoveryPhraseRoute(finishPath: finishPath)
            .push<void>(context),
      );
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/back_button.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/recovery_phrase_text_view.dart';
import '../../../ui/theme.dart';
import '../widgets/grid_phrase.dart';
import 'success_screen.dart';

class ConfirmRecoveryPhraseScreen extends StatefulWidget {
  const ConfirmRecoveryPhraseScreen({
    super.key,
    required this.correctPhrase,
    required this.onConfirmed,
  });

  final String correctPhrase;
  final VoidCallback onConfirmed;

  @override
  State<ConfirmRecoveryPhraseScreen> createState() =>
      _ConfirmRecoveryPhraseScreenState();
}

class _ConfirmRecoveryPhraseScreenState
    extends State<ConfirmRecoveryPhraseScreen> {
  String _currentPhrase = '';

  @override
  Widget build(BuildContext context) {
    final correctPhrase = widget.correctPhrase;

    return CpTheme.black(
      child: Scaffold(
        body: OnboardingScreen(
          footer: OnboardingFooterButton(
            text: context.l10n.next,
            onPressed:
                _currentPhrase == correctPhrase ? widget.onConfirmed : null,
          ),
          children: [
            CpAppBar(
              leading: const CpBackButton(),
            ),
            const OnboardingLogo(),
            OnboardingDescription(text: context.l10n.completeThePuzzle),
            OnboardingPadding(
              child: RecoveryPhraseTextView(
                phrase: _currentPhrase,
                hasCopyButton: false,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 200,
              child: OnboardingPadding(
                child: GridPhrase(
                  correctPhrase: widget.correctPhrase,
                  callback: (phrase) => setState(() => _currentPhrase = phrase),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingConfirmRecoveryPhraseRoute extends GoRouteData {
  const OnboardingConfirmRecoveryPhraseRoute(
    this.$extra, {
    required this.finishPath,
  });

  final String $extra;
  final String finishPath;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ConfirmRecoveryPhraseScreen(
        correctPhrase: $extra,
        onConfirmed: () =>
            OnboardingSuccessRoute(finishPath: finishPath).push<void>(context),
      );
}

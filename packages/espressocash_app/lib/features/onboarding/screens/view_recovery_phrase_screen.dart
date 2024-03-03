import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/recovery_phrase_text_view.dart';
import '../../../ui/theme.dart';
import '../../accounts/data/account_repository.dart';
import 'confirm_recovery_phrase_screen.dart';

class ViewRecoveryPhraseScreen extends StatefulWidget {
  const ViewRecoveryPhraseScreen({
    super.key,
    required this.onConfirmed,
    this.buttonLabel,
  });

  final ValueSetter<String> onConfirmed;
  final String? buttonLabel;

  @override
  State<ViewRecoveryPhraseScreen> createState() =>
      _ViewRecoveryPhraseScreenState();
}

class _ViewRecoveryPhraseScreenState extends State<ViewRecoveryPhraseScreen> {
  String _phrase = '';

  @override
  void initState() {
    super.initState();
    sl<AccountRepository>().loadMnemonic().then((String? phrase) {
      if (phrase != null) {
        setState(() => _phrase = phrase);
      }
    });
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: widget.buttonLabel ?? context.l10n.next,
              onPressed: () => widget.onConfirmed(_phrase),
            ),
            children: [
              CpAppBar(),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.yourRecoveryPhrase),
              OnboardingDescription(text: context.l10n.yourRecoveryPhraseSub),
              OnboardingPadding(
                child: RecoveryPhraseTextView(phrase: _phrase),
              ),
            ],
          ),
        ),
      );
}

class OnboardingRecoveryPhraseRoute extends GoRouteData {
  const OnboardingRecoveryPhraseRoute({required this.finishPath});

  final String finishPath;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      ViewRecoveryPhraseScreen(
        onConfirmed: (phrase) =>
            OnboardingConfirmRecoveryPhraseRoute(phrase, finishPath: finishPath)
                .push<void>(context),
      );
}

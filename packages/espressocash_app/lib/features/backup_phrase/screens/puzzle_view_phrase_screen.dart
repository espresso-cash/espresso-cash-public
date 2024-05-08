import 'package:flutter/material.dart';

import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/onboarding_screen.dart';
import '../../../../ui/recovery_phrase_text_view.dart';
import '../../../../ui/theme.dart';
import '../../accounts/data/account_repository.dart';

class PuzzleViewPhraseScreen extends StatefulWidget {
  const PuzzleViewPhraseScreen({
    super.key,
    required this.onConfirmed,
  });

  final ValueSetter<String> onConfirmed;

  @override
  State<PuzzleViewPhraseScreen> createState() => _PuzzleViewPhraseScreenState();
}

class _PuzzleViewPhraseScreenState extends State<PuzzleViewPhraseScreen> {
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
              text: context.l10n.next,
              onPressed: () => widget.onConfirmed(_phrase),
            ),
            children: [
              const CpAppBar(),
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

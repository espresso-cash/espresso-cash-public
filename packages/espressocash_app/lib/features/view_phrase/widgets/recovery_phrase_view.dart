import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/back_button.dart';
import '../../../ui/onboarding_screen.dart';
import '../../../ui/recovery_phrase_text_view.dart';
import '../../accounts/data/account_repository.dart';
import 'quiz_page.dart';

class RecoveryPhraseView extends StatefulWidget {
  const RecoveryPhraseView({
    super.key,
    required this.indicator,
  });

  final Widget indicator;

  @override
  State<RecoveryPhraseView> createState() => _RecoveryPhraseViewState();
}

class _RecoveryPhraseViewState extends State<RecoveryPhraseView> {
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
  Widget build(BuildContext context) => QuizPage(
        backButton: const CpBackButton(),
        indicator: widget.indicator,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const OnboardingLogo(),
              Text(
                context.l10n.yourRecoveryPhrase,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.25,
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  context.l10n.yourRecoveryPhraseSub,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.25,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              OnboardingPadding(
                child: RecoveryPhraseTextView(phrase: _phrase),
              ),
            ],
          ),
        ),
        footer: const [],
        type: QuizPageType.dark,
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/onboarding_screen.dart';
import '../../../../ui/recovery_phrase_text_view.dart';
import '../../../accounts/data/account_repository.dart';
import '../widgets/quiz_page.dart';

@RoutePage()
class QuizRecoveryScreen extends StatefulWidget {
  const QuizRecoveryScreen({
    super.key,
    required this.onComplete,
    required this.indicator,
  });

  static const route = QuizRecoveryRoute.new;

  final VoidCallback onComplete;
  final Indicator indicator;

  @override
  State<QuizRecoveryScreen> createState() => _QuizRecoveryScreenState();
}

class _QuizRecoveryScreenState extends State<QuizRecoveryScreen> {
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
        backButton: CpBackButton(
          onPressed: widget.onComplete,
        ),
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

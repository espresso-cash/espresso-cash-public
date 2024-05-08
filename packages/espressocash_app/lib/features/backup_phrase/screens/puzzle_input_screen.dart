import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/onboarding_screen.dart';
import '../../../../ui/recovery_phrase_text_view.dart';
import '../../../../ui/theme.dart';
import '../widgets/grid_phrase.dart';

class PuzzleInputScreen extends StatefulWidget {
  const PuzzleInputScreen({
    super.key,
    required this.correctPhrase,
    required this.onConfirmed,
  });

  final String correctPhrase;
  final VoidCallback onConfirmed;

  @override
  State<PuzzleInputScreen> createState() => _PuzzleInputScreenState();
}

class _PuzzleInputScreenState extends State<PuzzleInputScreen> {
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
            const CpAppBar(),
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

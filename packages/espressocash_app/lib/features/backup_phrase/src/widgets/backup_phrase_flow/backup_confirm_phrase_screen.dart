import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/back_button.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/recovery_phrase_text_view.dart';
import '../../../../../ui/theme.dart';
import 'backup_phrase_flow_screen.dart';
import 'components/grid_phrase.dart';

class BackupConfirmPhraseScreen extends StatefulWidget {
  const BackupConfirmPhraseScreen({
    Key? key,
    required this.correctPhrase,
  }) : super(key: key);

  final String correctPhrase;

  @override
  State<BackupConfirmPhraseScreen> createState() =>
      _BackupConfirmPhraseScreenState();
}

class _BackupConfirmPhraseScreenState extends State<BackupConfirmPhraseScreen> {
  String _currentPhrase = '';

  void _onConfirmed() {
    context.read<BackupPhraseRouter>().onConfirmed();
  }

  @override
  Widget build(BuildContext context) {
    final correctPhrase = widget.correctPhrase;

    return CpTheme.dark(
      child: Scaffold(
        body: OnboardingScreen(
          footer: OnboardingFooterButton(
            text: context.l10n.next,
            onPressed: _currentPhrase == correctPhrase ? _onConfirmed : null,
          ),
          children: [
            CpAppBar(
              leading: CpBackButton(onPressed: () => context.router.pop()),
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
            )
          ],
        ),
      ),
    );
  }
}

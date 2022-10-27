import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/components/grid_phrase.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/onboarding_screen.dart';
import 'package:cryptoplease/ui/recovery_phrase_text_view.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          footer: FooterButton(
            text: context.l10n.next,
            onPressed: _currentPhrase == correctPhrase ? _onConfirmed : null,
          ),
          children: [
            CpAppBar(),
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

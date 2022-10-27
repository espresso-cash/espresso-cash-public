import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/features/backup_phrase/presentation/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/onboarding_screen.dart';
import 'package:cryptoplease/ui/recovery_phrase_text_view.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BackupPhraseScreen extends StatefulWidget {
  const BackupPhraseScreen({Key? key}) : super(key: key);

  @override
  State<BackupPhraseScreen> createState() => _BackupPhraseScreenState();
}

class _BackupPhraseScreenState extends State<BackupPhraseScreen> {
  String _phrase = '';

  @override
  void initState() {
    super.initState();
    loadMnemonic(const FlutterSecureStorage()).then((String? phrase) {
      if (phrase != null) {
        setState(() => _phrase = phrase);
      }
    });
  }

  void _goToConfirmPage() {
    context.read<BackupPhraseRouter>().onGoToConfirmationScreen(_phrase);
  }

  void _closeFlow() {
    context.read<BackupPhraseRouter>().closeFlow(solved: false);
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          body: OnboardingScreen(
            footer: OnboardingFooterButton(
              text: context.l10n.next,
              onPressed: _goToConfirmPage,
            ),
            children: [
              CpAppBar(leading: BackButton(onPressed: _closeFlow)),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.yourRecoveryPhrase),
              OnboardingDescription(text: context.l10n.recoverySubHeading),
              OnboardingPadding(child: RecoveryPhraseTextView(phrase: _phrase)),
            ],
          ),
        ),
      );
}

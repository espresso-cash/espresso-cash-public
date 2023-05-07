import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../l10n/l10n.dart';
import '../../../../../ui/app_bar.dart';
import '../../../../../ui/back_button.dart';
import '../../../../../ui/onboarding_screen.dart';
import '../../../../../ui/recovery_phrase_text_view.dart';
import '../../../../../ui/theme.dart';
import '../../../mnemonic_getter.dart';
import 'backup_phrase_flow_screen.dart';

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
    context.read<MnemonicGetter>().mnemonic.then((String? phrase) {
      if (phrase != null) {
        setState(() => _phrase = phrase);
      }
    });
  }

  void _goToConfirmPage() {
    context.read<BackupPhraseRouter>().onGoToConfirmationScreen(_phrase);
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
              CpAppBar(
                leading: CpBackButton(onPressed: () => context.router.pop()),
              ),
              const OnboardingLogo(),
              OnboardingTitle(text: context.l10n.yourRecoveryPhrase),
              OnboardingDescription(text: context.l10n.recoverySubHeading),
              OnboardingPadding(child: RecoveryPhraseTextView(phrase: _phrase)),
            ],
          ),
        ),
      );
}

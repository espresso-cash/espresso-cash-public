import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease/presentation/components/recovery_phrase_text_view.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
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
  Widget build(BuildContext context) => DecoratedWindow(
        nextButton: CpButton(
          text: context.l10n.next,
          onPressed: _goToConfirmPage,
        ),
        backButton: BackButton(onPressed: _closeFlow),
        title: context.l10n.yourRecoveryPhrase.toUpperCase(),
        message: context.l10n.recoverySubHeading,
        child: CpContentPadding(
          child: Column(
            children: [
              RecoveryPhraseTextView(
                phrase: _phrase,
                backgroundColor: CpColors.lightGreyBackground,
              )
            ],
          ),
        ),
      );
}

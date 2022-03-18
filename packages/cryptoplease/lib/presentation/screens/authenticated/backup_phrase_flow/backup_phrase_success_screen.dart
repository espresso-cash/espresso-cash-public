import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/common_success.dart';
import 'package:cryptoplease/presentation/screens/authenticated/backup_phrase_flow/backup_phrase_flow_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackupPhraseSuccessScreen extends StatelessWidget {
  const BackupPhraseSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CommonSuccess(
        text: context.l10n.backupPhraseSuccessMessage,
        onClosePressed: () =>
            context.read<BackupPhraseRouter>().closeFlow(solved: true),
      );
}

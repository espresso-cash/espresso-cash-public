import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/puzzle_reminder/puzzle_reminder_bloc.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackupPhraseFlowScreen extends StatefulWidget {
  const BackupPhraseFlowScreen({Key? key}) : super(key: key);

  @override
  State<BackupPhraseFlowScreen> createState() => _BackupPhraseFlowScreenState();
}

class _BackupPhraseFlowScreenState extends State<BackupPhraseFlowScreen>
    implements BackupPhraseRouter {
  @override
  void onGoToConfirmationScreen(String phrase) {
    context.router.push(BackupConfirmPhraseRoute(correctPhrase: phrase));
  }

  @override
  void onConfirmed() {
    context.read<PuzzleReminderBloc>().add(const PuzzleReminderEvent.solved());

    context.router.replaceAll([const BackupPhraseSuccessRoute()]);
  }

  @override
  void closeFlow({required bool solved}) {
    Navigator.of(context).pop(solved);
  }

  @override
  Widget build(BuildContext context) => Provider<BackupPhraseRouter>.value(
        value: this,
        child: const AutoRouter(),
      );
}

abstract class BackupPhraseRouter {
  void onGoToConfirmationScreen(String phrase);

  void onConfirmed();

  void closeFlow({required bool solved});
}

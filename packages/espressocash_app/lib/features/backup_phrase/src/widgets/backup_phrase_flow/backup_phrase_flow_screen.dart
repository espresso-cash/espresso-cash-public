import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../routes.gr.dart';
import '../../bl/puzzle_reminder_bloc.dart';

class BackupPhraseFlowScreen extends StatefulWidget {
  const BackupPhraseFlowScreen({super.key});

  @override
  State<BackupPhraseFlowScreen> createState() => _BackupPhraseFlowScreenState();
}

class _BackupPhraseFlowScreenState extends State<BackupPhraseFlowScreen>
    implements BackupPhraseRouter {
  final _navigatorKey = GlobalKey<AutoRouterState>();

  @override
  void onWarningConfirmed() {
    _navigatorKey.currentState?.controller?.replace(const BackupPhraseRoute());
  }

  @override
  void onGoToConfirmationScreen(String phrase) {
    _navigatorKey.currentState?.controller
        ?.push(BackupConfirmPhraseRoute(correctPhrase: phrase));
  }

  @override
  void onConfirmed() {
    context.read<PuzzleReminderBloc>().add(const PuzzleReminderEvent.solved());

    _navigatorKey.currentState?.controller
        ?.replaceAll([const BackupPhraseSuccessRoute()]);
  }

  @override
  void closeFlow({required bool solved}) {
    context.router.pop(solved);
  }

  @override
  Widget build(BuildContext context) => Provider<BackupPhraseRouter>.value(
        value: this,
        child: AutoRouter(key: _navigatorKey),
      );
}

abstract class BackupPhraseRouter {
  const BackupPhraseRouter();

  void onWarningConfirmed();

  void onGoToConfirmationScreen(String phrase);

  void onConfirmed();

  void closeFlow({required bool solved});
}

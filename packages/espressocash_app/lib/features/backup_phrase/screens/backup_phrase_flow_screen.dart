import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../routes.gr.dart';
import '../services/puzzle_reminder_bloc.dart';
import 'backup_confirm_phrase_screen.dart';
import 'backup_phrase_screen.dart';
import 'backup_phrase_success_screen.dart';

@RoutePage<bool>()
class BackupPhraseFlowScreen extends StatefulWidget {
  const BackupPhraseFlowScreen({super.key});

  static const route = BackupPhraseFlowRoute.new;

  @override
  State<BackupPhraseFlowScreen> createState() => _BackupPhraseFlowScreenState();
}

class _BackupPhraseFlowScreenState extends State<BackupPhraseFlowScreen>
    implements BackupPhraseRouter {
  final _navigatorKey = GlobalKey<AutoRouterState>();

  @override
  void onWarningConfirmed() {
    _navigatorKey.currentState?.controller?.replace(BackupPhraseScreen.route());
  }

  @override
  void onGoToConfirmationScreen(String phrase) {
    _navigatorKey.currentState?.controller
        ?.push(BackupConfirmPhraseScreen.route(correctPhrase: phrase));
  }

  @override
  void onConfirmed() {
    context.read<PuzzleReminderBloc>().add(const PuzzleReminderEvent.solved());

    _navigatorKey.currentState?.controller
        ?.replaceAll([BackupPhraseSuccessScreen.route()]);
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

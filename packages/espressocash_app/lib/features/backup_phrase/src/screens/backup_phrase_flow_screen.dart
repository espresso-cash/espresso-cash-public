import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../routes.gr.dart';
import '../../../../core/router_wrapper.dart';
import '../services/puzzle_reminder_bloc.dart';
import 'backup_confirm_phrase_screen.dart';
import 'backup_phrase_screen.dart';
import 'backup_phrase_success_screen.dart';
import 'backup_warning_screen.dart';

@RoutePage<bool>()
class BackupPhraseFlowScreen extends StatefulWidget {
  const BackupPhraseFlowScreen({super.key});

  static const route = BackupPhraseFlowRoute.new;

  @override
  State<BackupPhraseFlowScreen> createState() => _BackupPhraseFlowScreenState();
}

class _BackupPhraseFlowScreenState extends State<BackupPhraseFlowScreen>
    with RouterWrapper {
  void _handleWarningConfirmed() => router
      ?.replace(BackupPhraseScreen.route(onConfirmed: _handlePhraseConfirmed));

  void _handlePhraseConfirmed(String phrase) {
    router?.push(
      BackupConfirmPhraseScreen.route(
        correctPhrase: phrase,
        onConfirmed: _handleCompleted,
      ),
    );
  }

  void _handleCompleted() {
    context.read<PuzzleReminderBloc>().add(const PuzzleReminderEvent.solved());

    router?.replaceAll([
      BackupPhraseSuccessScreen.route(onSolved: () => context.router.pop(true)),
    ]);
  }

  @override
  PageRouteInfo get initialRoute => BackupWarningScreen.route(
        onConfirmed: _handleWarningConfirmed,
      );

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}

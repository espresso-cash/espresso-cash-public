import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../utils/routing.dart';
import '../services/puzzle_reminder_bloc.dart';
import 'puzzle_confirm_recovery_screen.dart';
import 'puzzle_success_screen.dart';
import 'puzzle_view_recovery_screen.dart';

class PuzzleFlowScreen extends StatefulWidget {
  const PuzzleFlowScreen({super.key});

  static void open(BuildContext context, {NavigatorState? navigator}) =>
      (navigator ?? Navigator.of(context, rootNavigator: true)).push<void>(
        MaterialPageRoute(builder: (context) => const PuzzleFlowScreen()),
      );

  @override
  State<PuzzleFlowScreen> createState() => _PuzzleFlowScreenState();
}

class _PuzzleFlowScreenState extends State<PuzzleFlowScreen> {
  void _handleRecoveryPhraseCompleted(String phrase) =>
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => PuzzleConfirmRecoveryScreen(
            correctPhrase: phrase,
            onConfirmed: _handleRecoveryPhraseConfirmed,
          ),
        ),
      );

  void _handleRecoveryPhraseConfirmed() => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => PuzzleSuccessScreen(
            onDone: _handleSuccessDone,
          ),
        ),
      );

  void _handleSuccessDone() {
    sl<PuzzleReminderBloc>().add(const PuzzleReminderEvent.solved());
    context.openFirstScreen();
  }

  @override
  Widget build(BuildContext context) => PuzzleViewRecoveryScreen(
        onConfirmed: _handleRecoveryPhraseCompleted,
      );
}

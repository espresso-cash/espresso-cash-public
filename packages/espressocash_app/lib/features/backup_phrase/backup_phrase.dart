import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/screens/view_phrase_flow_screen.dart';
import 'src/services/puzzle_reminder_bloc.dart';

export 'src/widgets/backup_phrase_module.dart';

extension BuildContextExt on BuildContext {
  void launchViewRecoveryPhraseFlow() =>
      router.push(ViewPhraseFlowScreen.route());

  void completePuzzleFlow() =>
      read<PuzzleReminderBloc>().add(const PuzzleReminderEvent.solved());
}

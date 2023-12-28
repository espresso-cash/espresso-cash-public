import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/services/puzzle_reminder_bloc.dart';

export 'src/widgets/backup_phrase_module.dart';

extension BuildContextExt on BuildContext {
  void completePuzzleFlow() =>
      read<PuzzleReminderBloc>().add(const PuzzleReminderEvent.solved());
}

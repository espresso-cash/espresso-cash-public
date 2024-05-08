import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di.dart';
import '../../accounts/models/account.dart';
import '../screens/puzzle_reminder_screen.dart';
import '../services/puzzle_reminder_bloc.dart';

class BackupPhraseModule extends StatefulWidget {
  const BackupPhraseModule({super.key, this.child});

  final Widget? child;

  @override
  State<BackupPhraseModule> createState() => _BackupPhraseModuleState();
}

class _BackupPhraseModuleState extends State<BackupPhraseModule> {
  @override
  void initState() {
    super.initState();

    final event = PuzzleReminderEvent.checkRequested(
      accessMode: sl<MyAccount>().accessMode,
      wallet: sl<MyAccount>().wallet,
    );
    sl<PuzzleReminderBloc>().add(event);
  }

  void _showPuzzleReminderDialog() => PuzzleReminderScreen.push(context);

  @override
  Widget build(BuildContext context) =>
      BlocListener<PuzzleReminderBloc, PuzzleReminderState>(
        bloc: sl<PuzzleReminderBloc>(),
        listener: (context, state) {
          if (state is PuzzleReminderStateRemindNow) {
            _showPuzzleReminderDialog();
          }
        },
        child: widget.child,
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/features/backup_phrase/bl/puzzle_reminder_bloc.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupPhraseModule extends SingleChildStatelessWidget {
  const BackupPhraseModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocProvider<PuzzleReminderBloc>(
        create: (_) => PuzzleReminderBloc(context.read<SharedPreferences>()),
        child: _Content(child: child),
      );
}

class _Content extends StatefulWidget {
  const _Content({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  void initState() {
    super.initState();
    context
        .read<PuzzleReminderBloc>()
        .add(const PuzzleReminderEvent.checkRequested());
  }

  void _showPuzzleReminderDialog() {
    context.router.push(const PuzzleReminderRoute());
  }

  @override
  Widget build(BuildContext context) => Nested(
        children: [
          BlocListener<AccountsBloc, AccountsState>(
            listenWhen: (s1, s2) => s1.account != s2.account,
            listener: (context, state) {
              if (state.account == null) {
                context
                    .read<PuzzleReminderBloc>()
                    .add(const PuzzleReminderEvent.loggedOut());
              }
            },
          ),
          BlocListener<PuzzleReminderBloc, PuzzleReminderState>(
            listener: (context, state) {
              if (state is PuzzleReminderStateRemindNow) {
                _showPuzzleReminderDialog();
              }
            },
          ),
        ],
        child: widget.child,
      );
}

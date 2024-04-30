import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../accounts/models/account.dart';
import '../../accounts/widgets/account_listener.dart';
import '../screens/puzzle_reminder_message_screen.dart';
import '../services/puzzle_reminder_bloc.dart';

class BackupPhraseModule extends SingleChildStatelessWidget {
  const BackupPhraseModule({
    super.key,
    super.child,
  });

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<PuzzleReminderBloc>(
            create: (_) => sl<PuzzleReminderBloc>(),
          ),
        ],
        child: _Content(child: child),
      );
}

class _Content extends StatefulWidget {
  const _Content({this.child});

  final Widget? child;

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> with AccountListener {
  @override
  void initState() {
    super.initState();

    final event = PuzzleReminderEvent.checkRequested(
      accessMode: context.read<MyAccount>().accessMode,
      wallet: context.read<MyAccount>().wallet,
    );
    context.read<PuzzleReminderBloc>().add(event);
  }

  void _showPuzzleReminderDialog() => PuzzleReminderMessageScreen.push(context);

  @override
  void handleAccountChanged(MyAccount? account) {
    if (account == null) {
      context
          .read<PuzzleReminderBloc>()
          .add(const PuzzleReminderEvent.loggedOut());
    }
  }

  @override
  Widget build(BuildContext context) =>
      BlocListener<PuzzleReminderBloc, PuzzleReminderState>(
        listener: (context, state) {
          if (state is PuzzleReminderStateRemindNow) {
            _showPuzzleReminderDialog();
          }
        },
        child: widget.child,
      );
}

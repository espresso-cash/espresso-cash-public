import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/bl/accounts_bloc.dart';
import '../../di.dart';
import '../../routes.gr.dart';
import 'mnemonic_getter.dart';
import 'src/bl/puzzle_reminder_bloc.dart';

class BackupPhraseModule extends SingleChildStatelessWidget {
  const BackupPhraseModule({
    Key? key,
    Widget? child,
    required this.mnemonic,
  }) : super(key: key, child: child);

  final Future<String> mnemonic;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<PuzzleReminderBloc>(
            create: (_) => sl<PuzzleReminderBloc>(),
          ),
          Provider<MnemonicGetter>(create: (_) => MnemonicGetter(mnemonic)),
        ],
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

    final accessMode = context.read<MyAccount>().accessMode;
    context
        .read<PuzzleReminderBloc>()
        .add(PuzzleReminderEvent.checkRequested(accessMode));
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

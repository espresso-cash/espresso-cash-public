import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
import '../callback.dart';
import 'bl/accounts_bloc.dart';

class AccountsModule extends SingleChildStatelessWidget {
  const AccountsModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) =>
            sl<AccountsBloc>()..add(const AccountsEvent.initialize()),
        child: child,
      );
}

class LogoutListener extends SingleChildStatelessWidget {
  const LogoutListener({
    Key? key,
    Widget? child,
    required this.onLogout,
  }) : super(key: key, child: child);

  final Callback1<BuildContext> onLogout;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) =>
      BlocListener<AccountsBloc, AccountsState>(
        listenWhen: (s1, s2) => s1.account != s2.account,
        listener: (context, state) {
          if (state.account == null) {
            onLogout(context);
          }
        },
        child: child,
      );
}

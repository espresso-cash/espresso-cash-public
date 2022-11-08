import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';

import '../../di.dart';
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

import 'package:cryptoplease/accounts/bl/accounts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nested/nested.dart';

class AccountsModule extends SingleChildStatelessWidget {
  const AccountsModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => AccountsBloc(
          storage: const FlutterSecureStorage(),
        )..add(const AccountsEvent.initialize()),
        child: child,
      );
}

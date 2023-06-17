import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import '../accounts/models/account.dart';
import '../accounts/module.dart';
import 'services/bloc.dart';

class ActivitiesModule extends SingleChildStatelessWidget {
  const ActivitiesModule({super.key, super.child});

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<TxUpdaterBloc>(
            create: (context) => sl<TxUpdaterBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: LogoutListener(
          onLogout: (context) =>
              context.read<TxUpdaterBloc>().add(const TxUpdaterEvent.clear()),
          child: child,
        ),
      );
}

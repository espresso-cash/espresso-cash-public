import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/module.dart';
import '../../core/balances/context_ext.dart';
import '../../di.dart';
import '../swap/swap_verifier.dart';
import 'src/updater/bloc.dart';

class ActivitiesModule extends SingleChildStatelessWidget {
  const ActivitiesModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<TxUpdaterBloc>(
            create: (context) => sl<TxUpdaterBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
          Provider<SwapVerifier>(
            lazy: false,
            create: (context) => sl<SwapVerifier>()
              ..init(onBalanceAffected: () => context.notifyBalanceAffected()),
            dispose: (_, value) => value.dispose(),
          ),
        ],
        child: LogoutListener(
          onLogout: (context) =>
              context.read<TxUpdaterBloc>().add(const TxUpdaterEvent.clear()),
          child: child,
        ),
      );
}

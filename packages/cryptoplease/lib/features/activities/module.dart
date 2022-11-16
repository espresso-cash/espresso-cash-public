import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/accounts/bl/accounts_bloc.dart';
import '../../di.dart';
import 'src/oskp_cancel/bloc.dart';
import 'src/updater/bloc.dart';

export 'src/components/pending_activities_list.dart';
export 'src/components/transaction_list.dart';
export 'src/oskp_cancel/repository.dart';
export 'src/transaction.dart';
export 'src/updater/tx_updater_repository.dart' show TransactionRows;

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
          BlocProvider<OSKPCancelBloc>(
            create: (context) => sl<OSKPCancelBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: BlocListener<AccountsBloc, AccountsState>(
          listenWhen: (s1, s2) => s1.account != s2.account,
          listener: (context, state) {
            if (state.account == null) {
              context.read<TxUpdaterBloc>().add(const TxUpdaterEvent.clear());
            }
          },
          child: child,
        ),
      );
}

import 'package:cryptoplease/core/accounts/bl/accounts_bloc.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/split_key_payments/transaction/tx_creator_selector.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/bloc.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/repository.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/bl/tx_processor.dart';
import 'package:cryptoplease/features/incoming_split_key_payment/data/split_key_payments_repository.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solana/solana.dart';

class IncomingSplitKeyPaymentModule extends SingleChildStatelessWidget {
  const IncomingSplitKeyPaymentModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<SplitKeyIncomingRepository>(
            create: (_) => SharedPrefsSplitKeyIncomingRepository(
              context.read<SharedPreferences>(),
            ),
          ),
          BlocProvider(
            create: (context) => SplitKeyIncomingPaymentBloc(
              txProcessor: TxProcessor(context.read<SolanaClient>()),
              repository: context.read<SplitKeyIncomingRepository>(),
              txCreatorSelector: context.read<TxCreatorSelector>(),
            ),
          ),
        ],
        child:
            BlocListener<SplitKeyIncomingPaymentBloc, SplitKeyIncomingPayment>(
          listener: (context, state) => state.whenOrNull(
            success: () => context
                .read<AccountsBloc>()
                .state
                .account
                ?.let((a) => BalancesEvent.requested(address: a.address))
                .let(context.read<BalancesBloc>().add),
          ),
          child: child,
        ),
      );
}

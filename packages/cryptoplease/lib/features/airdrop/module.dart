import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/features/airdrop/bl/airdrop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:solana/solana.dart';

class AirdropModule extends SingleChildStatelessWidget {
  const AirdropModule({
    Key? key,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => AirdropBloc(
          solanaClient: context.read<SolanaClient>(),
          onAirdropCompleted: () {
            final address = context.read<MyAccount>().address;
            context
                .read<BalancesBloc>()
                .add(BalancesEvent.requested(address: address));
          },
          account: context.read<MyAccount>().publicKey,
        ),
        child: child,
      );
}

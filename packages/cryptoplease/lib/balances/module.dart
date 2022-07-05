import 'package:cryptoplease/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/tokens/token_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:solana/solana.dart';

class BalancesModule extends SingleChildStatelessWidget {
  const BalancesModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => BalancesBloc(
          solanaClient: context.read<SolanaClient>(),
          tokens: context.read<TokenList>(),
        ),
        child: child,
      );
}

import 'package:cryptoplease/authenticated/airdrop/bl/airdrop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:solana/solana.dart';

class AirdropModule extends SingleChildStatelessWidget {
  const AirdropModule({
    Key? key,
    required this.onAirdropCompleted,
    required this.account,
    Widget? child,
  }) : super(key: key, child: child);

  final Ed25519HDPublicKey account;
  final VoidCallback onAirdropCompleted;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => BlocProvider(
        create: (context) => AirdropBloc(
          solanaClient: context.read<SolanaClient>(),
          onAirdropCompleted: onAirdropCompleted,
          account: account,
        ),
        child: child,
      );
}

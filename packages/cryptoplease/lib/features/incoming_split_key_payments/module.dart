import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/transactions/tx_sender.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_bloc.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/iskp_repository.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/bl/pending_iskp_repository.dart';
import 'package:cryptoplease/features/incoming_split_key_payments/data/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class ISKPModule extends SingleChildStatelessWidget {
  const ISKPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<ISKPRepository>(
            create: (context) => DbISKPRepository(context.read<MyDatabase>()),
          ),
          Provider<PendingISKPRepository>(
            create: (_) => PendingISKPRepository(),
          ),
          BlocProvider<ISKPBloc>(
            create: (context) => ISKPBloc(
              repository: context.read<ISKPRepository>(),
              client: context.read<CryptopleaseClient>(),
              account: context.read<MyAccount>().wallet,
              txSender: TxSender(client: context.read<SolanaClient>()),
            ),
          ),
        ],
        child: child,
      );
}

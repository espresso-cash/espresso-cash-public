import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/core/transactions/tx_sender.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/bloc.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_direct_payments/data/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class ODPModule extends SingleChildStatelessWidget {
  const ODPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<ODPRepository>(
            create: (context) => DbODPRepository(
              context.read<MyDatabase>(),
              context.read<TokenList>(),
            ),
          ),
          BlocProvider<ODPBloc>(
            create: (context) => ODPBloc(
              repository: context.read<ODPRepository>(),
              client: context.read<CryptopleaseClient>(),
              account: context.read<MyAccount>().wallet,
              txSender: TxSender(client: context.read<SolanaClient>()),
            ),
          ),
        ],
        child: child,
      );
}

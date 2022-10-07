import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/core/tx_sender.dart';
import 'package:cryptoplease/data/db/db.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/bloc.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/data/repository.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class OSKPModule extends SingleChildStatelessWidget {
  const OSKPModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<OSKPRepository>(
            create: (context) => DbOSKPRepository(
              context.read<MyDatabase>(),
              context.read<TokenList>(),
            ),
          ),
          BlocProvider<OSKPBloc>(
            create: (context) => OSKPBloc(
              repository: context.read<OSKPRepository>(),
              client: context.read<CryptopleaseClient>(),
              account: context.read<MyAccount>().wallet,
              txSender: TxSender(client: context.read<SolanaClient>()),
            ),
          ),
        ],
        child: child,
      );
}

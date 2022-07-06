import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/features/nft/bl/nft_collection/bloc.dart';
import 'package:cryptoplease/features/nft/bl/offchain_metadata_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

class NftModule extends SingleChildStatelessWidget {
  const NftModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<OffchainMetadataRepository>(
            create: (_) => OffchainMetadataRepository(),
          ),
          BlocProvider(
            create: (context) => NftCollectionBloc(
              solanaClient: context.read<SolanaClient>(),
              account: context.read<MyAccount>(),
            ),
          ),
        ],
        child: child,
      );
}

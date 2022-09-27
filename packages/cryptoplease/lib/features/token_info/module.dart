import 'package:cryptoplease/features/token_info/bl/repository.dart';
import 'package:cryptoplease/features/token_info/bl/token_info_bloc.dart';
import 'package:cryptoplease/features/token_info/data/coingecko_client.dart';
import 'package:cryptoplease/features/token_info/data/token_info_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class TokenInfoModule extends SingleChildStatelessWidget {
  const TokenInfoModule({Key? key, Widget? child})
      : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          Provider<TokenInfoRepository>(
            create: (_) => CoingeckoTokenInfoRepository(
              coingeckoClient: CoingeckoClient(),
            ),
          ),
          BlocProvider(
            create: (context) => TokenInfoBloc(
              repository: context.read<TokenInfoRepository>(),
            ),
          )
        ],
        child: child,
      );
}

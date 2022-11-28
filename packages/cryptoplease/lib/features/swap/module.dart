import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import '../../core/accounts/bl/account.dart';
import '../../core/tokens/token.dart';
import '../../di.dart';
import '../../routes.gr.dart';
import 'bl/swap/swap_bloc.dart';

extension BuyTokenExt on BuildContext {
  void navigateToBuyToken(Token token) => navigateTo(
        SwapFlowRoute(
          inputToken: Token.usdc,
          outputToken: token,
        ),
      );
}

extension SellTokenExt on BuildContext {
  void navigateToSellToken(Token token) => navigateTo(
        SwapFlowRoute(
          inputToken: token,
          outputToken: Token.usdc,
        ),
      );
}

class SwapModule extends SingleChildStatelessWidget {
  const SwapModule({Key? key, Widget? child}) : super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) => MultiProvider(
        providers: [
          BlocProvider<SwapBloc>(
            create: (context) => sl<SwapBloc>(
              param1: context.read<MyAccount>().wallet,
            ),
          ),
        ],
        child: child,
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/accounts/bl/account.dart';
import '../../../core/tokens/token.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/loader.dart';
import '../models/swap.dart';
import '../models/swap_route.dart';
import '../services/swap_service.dart';

extension BuildContextExt on BuildContext {
  void navigateToBuyToken(Token token) => navigateTo(
        SwapFlowRoute(
          inputToken: Token.usdc,
          outputToken: token,
        ),
      );

  void navigateToSellToken(Token token) => navigateTo(
        SwapFlowRoute(
          inputToken: token,
          outputToken: Token.usdc,
        ),
      );
}

extension SwapExt on BuildContext {
  Future<String> createSwap(SwapRoute route) async =>
      runWithLoader(this, () async {
        final swap = await sl<SwapService>().create(
          route: route,
          account: read<MyAccount>().wallet,
        );

        return swap.id;
      });

  Future<void> retrySwap(Swap swap) async => runWithLoader(
        this,
        () => sl<SwapService>().retry(
          swap,
          account: read<MyAccount>().wallet,
        ),
      );
}

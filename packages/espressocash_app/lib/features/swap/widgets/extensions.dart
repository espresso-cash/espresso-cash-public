import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/tokens/token.dart';
import '../../../routes.gr.dart';

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

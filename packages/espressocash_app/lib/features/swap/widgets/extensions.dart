import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/tokens/token.dart';
import '../screens/swap_flow_screen.dart';

extension BuildContextExt on BuildContext {
  void navigateToBuyToken(Token token) => navigateTo(
        SwapFlowScreen.route(
          inputToken: Token.usdc,
          outputToken: token,
        ),
      );

  void navigateToSellToken(Token token) => navigateTo(
        SwapFlowScreen.route(
          inputToken: token,
          outputToken: Token.usdc,
        ),
      );
}

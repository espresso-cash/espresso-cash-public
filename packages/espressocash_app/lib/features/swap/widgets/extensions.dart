import 'package:flutter/material.dart';

import '../../../routing.dart';
import '../../tokens/token.dart';
import '../screens/swap_flow_screen.dart';

extension BuildContextExt on BuildContext {
  void navigateToBuyToken(Token token) =>
      CreateSwapRoute((input: Token.usdc, output: token)).push<void>(this);

  void navigateToSellToken(Token token) =>
      CreateSwapRoute((input: token, output: Token.usdc)).push<void>(this);
}

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/features/swap/bl/swap_verifier/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

extension SwapFlowExt on BuildContext {
  // void navigateToBuyToken(Token token);

  void navigateToSellToken(Token token) => navigateTo(
        SwapRoute(
          inputAmount: CryptoAmount(
            currency: CryptoCurrency(token: token),
            value: 10000000000,
          ),
          outputAmount: const CryptoAmount(
            currency: CryptoCurrency(token: Token.usdc),
            value: 25500000,
          ),
          slippage: Decimal.one,
        ),
      );
}

class SwapFlowScreen extends StatefulWidget {
  const SwapFlowScreen({
    Key? key,
    required this.input,
    required this.output,
    required this.slippage,
  }) : super(key: key);

  final Token input;
  final Token output;
  final Decimal slippage;

  @override
  State<SwapFlowScreen> createState() => _FlowState();
}

class _FlowState extends State<SwapFlowScreen> {
  late final SwapVerifierBloc swapVerifierBloc;
  late final CreateSwapBloc createSwapBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: AutoRouter(),
      );
}

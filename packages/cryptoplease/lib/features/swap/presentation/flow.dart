import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
import 'package:cryptoplease/features/swap/bl/swap_verifier/bloc.dart';
import 'package:cryptoplease/features/swap/swap_screen.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension SwapFlowExt on BuildContext {
  // void navigateToBuyToken(Token token);

  void navigateToSellToken(Token token) => navigateTo(
        SwapFlowRoute(
          inputToken: token,
          // TODO: remove
          outputToken: Token.usdcProd,
          slippage: Decimal.one,
        ),
      );
}

class SwapFlowScreen extends StatefulWidget {
  const SwapFlowScreen({
    Key? key,
    required this.inputToken,
    required this.outputToken,
    required this.slippage,
  }) : super(key: key);

  final Token inputToken;
  final Token outputToken;
  final Decimal slippage;

  @override
  State<SwapFlowScreen> createState() => _FlowState();
}

class _FlowState extends State<SwapFlowScreen> {
  late final CryptoAmount zero;
  late final SwapVerifierBloc swapVerifierBloc;
  late final CreateSwapBloc createSwapBloc;

  @override
  void initState() {
    super.initState();
    zero = CryptoAmount(
      value: 0,
      currency: CryptoCurrency(token: widget.inputToken),
    );
    createSwapBloc = CreateSwapBloc(
      jupiterAggregatorClient: context.read<JupiterAggregatorClient>(),
      tokenList: context.read<TokenList>(),
      balances: context.read<BalancesBloc>().state.balances.lock,
      analyticsManager: context.read<AnalyticsManager>(),
    )..add(
        CreateSwapEvent.init(
          widget.inputToken,
          widget.outputToken,
          widget.slippage,
        ),
      );
  }

  void _onSlippageUpdate(Decimal value) {
    createSwapBloc.add(CreateSwapEvent.slippageUpdated(value));
  }

  void _onAmountUpdate(Amount amount, Decimal value) {
    if (value == amount.decimal) return;

    createSwapBloc.add(CreateSwapEvent.amountUpdated(value));
  }

  void _onSwapException(SwapException e) => showErrorDialog(
        context,
        'Failed',
        e,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocConsumer<CreateSwapBloc, CreateSwapState>(
          bloc: createSwapBloc,
          listener: (context, state) => state.whenOrNull(
            failure: _onSwapException,
          ),
          builder: (context, state) {
            final amount = state.maybeMap(
              initialized: (state) => state.inputAmount,
              orElse: () => zero,
            );

            return SwapScreen(
              inputAmount: amount,
              outputAmount: state.maybeMap(
                initialized: (state) => state.outputAmount,
                orElse: () => null,
              ),
              slippage: state.slippage ?? widget.slippage,
              onSlippageChanged: _onSlippageUpdate,
              onAmountChanged: (value) => _onAmountUpdate(amount, value),
              onSubmit: ignore,
            );
          },
        ),
      );
}

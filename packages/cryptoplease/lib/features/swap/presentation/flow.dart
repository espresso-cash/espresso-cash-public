import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/dialogs.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/analytics/analytics_manager.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/tokens/token_list.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
import 'package:cryptoplease/features/swap/bl/swap_verifier/bloc.dart';
import 'package:cryptoplease/features/swap/swap_screen.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

extension SwapFlowExt on BuildContext {
  void navigateToBuyToken(Token token) => navigateTo(
        SwapFlowRoute(
          // TODO: remove
          inputToken: Token.usdcProd,
          outputToken: token,
          slippage: Decimal.one,
        ),
      );

  void navigateToSellToken(Token token) => navigateTo(
        SwapFlowRoute(
          inputToken: token,
          // TODO: remove
          outputToken: Token.usdcProd,
          slippage: Decimal.one,
        ),
      );
}

enum EditingMode { input, output }

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
  late final SwapVerifierBloc swapVerifierBloc;
  late final CreateSwapBloc createSwapBloc;
  late EditingMode editingMode;

  @override
  void initState() {
    super.initState();
    editingMode = EditingMode.input;
    createSwapBloc = CreateSwapBloc(
      jupiterAggregatorClient: sl<JupiterAggregatorClient>(),
      tokenList: sl<TokenList>(),
      balances: context.read<BalancesBloc>().state.balances.lock,
      analyticsManager: sl<AnalyticsManager>(),
    )..add(
        CreateSwapEvent.initialized(
          widget.inputToken,
          widget.outputToken,
          widget.slippage,
        ),
      );

    swapVerifierBloc = SwapVerifierBloc(
      jupiterAggregatorClient: sl<JupiterAggregatorClient>(),
      myAccount: context.read<MyAccount>(),
      solanaClient: sl<SolanaClient>(),
    );
  }

  void _onSubmit() => createSwapBloc.add(const CreateSwapEvent.submitted());

  void _onSlippageUpdate(Decimal value) {
    createSwapBloc.add(CreateSwapEvent.slippageUpdated(value));
  }

  void _onToggleEditingMode() => setState(
        () => editingMode = editingMode == EditingMode.input
            ? EditingMode.output
            : EditingMode.input,
      );

  void _onAmountUpdate(Amount amount, Decimal value) {
    if (value == amount.decimal) return;

    final event = editingMode == EditingMode.input
        ? CreateSwapEvent.inputUpdated(value)
        : CreateSwapEvent.outputUpdated(value);

    createSwapBloc.add(event);
  }

  void _onSwapException(SwapException e) => showErrorDialog(
        context,
        'Failed',
        e,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<SwapVerifierBloc, SwapVerifierState>(
          bloc: swapVerifierBloc,
          listener: (context, state) => state.whenOrNull(
            failed: _onSwapException,
          ),
          child: BlocConsumer<CreateSwapBloc, CreateSwapState>(
            bloc: createSwapBloc,
            listener: (context, state) => state.whenOrNull(
              failure: _onSwapException,
              success: (route) {
                print(route);
                swapVerifierBloc.add(
                  SwapVerifierEvent.swapRequested(jupiterRoute: route),
                );
              },
            ),
            builder: (context, state) {
              final inputAmount = state.maybeMap(
                initialized: (state) => state.inputAmount,
                orElse: () => CryptoAmount(
                  value: 0,
                  currency: CryptoCurrency(token: widget.inputToken),
                ),
              );
              final outputAmount = state.maybeMap(
                initialized: (state) => state.outputAmount,
                orElse: () => CryptoAmount(
                  value: 0,
                  currency: CryptoCurrency(token: widget.outputToken),
                ),
              );

              return SwapScreen(
                inputAmount: inputAmount,
                outputAmount: outputAmount,
                slippage: state.slippage ?? widget.slippage,
                loading: state.isLoadingRoute,
                onSlippageChanged: _onSlippageUpdate,
                onAmountChanged: (value) => _onAmountUpdate(inputAmount, value),
                onSubmit: _onSubmit,
                onToggleEditingMode: _onToggleEditingMode,
              );
            },
          ),
        ),
      );
}

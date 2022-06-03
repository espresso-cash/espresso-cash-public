import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/swap_tokens/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/bl/swap_tokens/transaction/swap_transaction_bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/routes.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/swap_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

abstract class SwapTokenRouter {
  void onSelectInputToken();
  void onSelectOutputToken();
  void onConfirm();
  void closeFlow();
}

class SwapTokenFlowScreen extends StatefulWidget {
  const SwapTokenFlowScreen({Key? key}) : super(key: key);

  @override
  State<SwapTokenFlowScreen> createState() => _State();
}

class _State extends State<SwapTokenFlowScreen> implements SwapTokenRouter {
  late final SwapSelectorBloc _selectorBloc;
  late final SwapTransactionBloc _transactionBloc;
  final routerKey = GlobalKey<AutoRouterState>();

  @override
  void initState() {
    super.initState();

    final jupiterClient = context.read<JupiterAggregatorClient>();

    _selectorBloc = SwapSelectorBloc(
      jupiterAggregatorClient: jupiterClient,
      tokenList: context.read<TokenList>(),
      balances: context.read<BalancesBloc>().state.balances,
    );
    _transactionBloc = SwapTransactionBloc(
      jupiterAggregatorClient: jupiterClient,
      myAccount: context.read<MyAccount>(),
      solanaClient: context.read<SolanaClient>(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => reloadOrderScreen());
    _reset();
  }

  @override
  void dispose() {
    _selectorBloc.close();
    super.dispose();
  }

  void _reset() {
    _selectorBloc.add(const SwapSelectorEvent.init());
  }

  void reloadOrderScreen() {
    final router = routerKey.currentState?.controller;
    router?.navigate(const SwapTokenOrderRoute());
  }

  @override
  void closeFlow() {
    _reset();
    final router = routerKey.currentState?.controller;
    router?.popUntilRoot();
  }

  @override
  Future<void> onSelectInputToken() async {
    final availableInputs = _selectorBloc.state.inputTokens;
    final token = await context.router
        .push<Token>(SwapTokenSelectorRoute(availableTokens: availableInputs));
    if (token != null) {
      _selectorBloc.add(SwapSelectorEvent.inputUpdated(token));
    }
  }

  @override
  Future<void> onSelectOutputToken() async {
    final availableOutputs = _selectorBloc.state.outputTokens;
    final token = await context.router.push<Token>(
      SwapTokenSelectorRoute(
        availableTokens: availableOutputs,
      ),
    );
    if (token != null) {
      _selectorBloc.add(SwapSelectorEvent.outputUpdated(token));
    }
  }

  @override
  void onConfirm() {
    final inputToken = _selectorBloc.state.input;
    final outputToken = _selectorBloc.state.output;
    final route = _selectorBloc.state.bestRoute;

    if (inputToken == null || outputToken == null || route == null) return;

    _transactionBloc.add(
      SwapTransactionEvent.swap(
        jupiterRoute: route,
      ),
    );

    context.router.push(const SwapTokenProcessRoute());
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider.value(value: _selectorBloc),
          BlocProvider.value(value: _transactionBloc),
          Provider<SwapTokenRouter>.value(value: this),
        ],
        child: BlocListener<SwapSelectorBloc, SwapSelectorState>(
          listenWhen: (previous, current) =>
              previous.routeProcessingState != current.routeProcessingState,
          listener: (context, state) => state.routeProcessingState?.whenOrNull(
            error: (error) => showSwapErrorDialog(
              context,
              context.l10n.errorLoadingTokens,
              error.reason,
            ),
          ),
          child: AutoRouter(key: routerKey),
        ),
      );
}

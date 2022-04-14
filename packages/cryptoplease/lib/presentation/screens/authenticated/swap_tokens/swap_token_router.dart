import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/bl/accounts/account.dart';
import 'package:cryptoplease/bl/balances/balances_bloc.dart';
import 'package:cryptoplease/bl/swap_tokens/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/bl/swap_tokens/transaction/swap_transaction_bloc.dart';
import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/bl/tokens/token_list.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jupiter_aggregator/jupiter_aggregator.dart';
import 'package:provider/provider.dart';

abstract class SwapTokenRouter {
  void onConfirm();
}

class SwapTokenFlowScreen extends StatefulWidget {
  const SwapTokenFlowScreen({
    Key? key,
    this.initialToken,
  }) : super(key: key);

  final Token? initialToken;

  @override
  State<SwapTokenFlowScreen> createState() => _State();
}

class _State extends State<SwapTokenFlowScreen> implements SwapTokenRouter {
  late final SwapSelectorBloc _selectorBloc;
  late final SwapTransactionBloc _transactionBloc;

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
    );
    _reset();
  }

  @override
  void dispose() {
    _selectorBloc.close();
    super.dispose();
  }

  void _reset() {
    _selectorBloc.add(const SwapSelectorEvent.load());
  }

  @override
  void onConfirm() {
    final inputToken = _selectorBloc.state.selectedInput;
    final outputToken = _selectorBloc.state.selectedOutput;
    final amount = _selectorBloc.state.amount;
    final slippage = _selectorBloc.state.slippage;

    if (inputToken == null || outputToken == null) return;

    _transactionBloc.add(
      SwapTransactionEvent.swap(
        inputToken: inputToken,
        outputToken: outputToken,
        amount: amount,
        slippage: slippage,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          BlocProvider.value(value: _selectorBloc),
          BlocProvider.value(value: _transactionBloc),
          Provider<SwapTokenRouter>.value(value: this),
        ],
        child: BlocListener<SwapTransactionBloc, SwapTransactionState>(
          listener: (context, state) => state.flow.maybeMap(
            success: (s) {
              // TODO(rhbrunetto): map
            },
            failure: (f) {
              // TODO(rhbrunetto): map
            },
            orElse: ignore,
          ),
          child: const AutoRouter(),
        ),
      );
}

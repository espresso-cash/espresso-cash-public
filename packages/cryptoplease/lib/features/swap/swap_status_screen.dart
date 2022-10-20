import 'package:cryptoplease/app/components/swap_status/swap_error.dart';
import 'package:cryptoplease/app/components/swap_status/swap_progress.dart';
import 'package:cryptoplease/app/components/swap_status/swap_success.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/features/swap/bl/swap_verifier/bloc.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class SwapStatusScreen extends StatefulWidget {
  const SwapStatusScreen({
    Key? key,
    required this.route,
    required this.operation,
  }) : super(key: key);

  final SwapOperation operation;
  final JupiterRoute route;

  @override
  State<SwapStatusScreen> createState() => _SwapStatusScreenState();
}

class _SwapStatusScreenState extends State<SwapStatusScreen> {
  late final SwapVerifierBloc verifierBloc;

  @override
  void initState() {
    super.initState();
    verifierBloc = SwapVerifierBloc(
      jupiterAggregatorClient: sl<JupiterAggregatorClient>(),
      myAccount: context.read<MyAccount>(),
      solanaClient: sl<SolanaClient>(),
    )..add(SwapVerifierEvent.swapRequested(jupiterRoute: widget.route));
  }

  void _onRetry() {
    const event = SwapVerifierEvent.retryRequested();
    verifierBloc.add(event);
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SwapVerifierBloc, SwapVerifierState>(
        bloc: verifierBloc,
        builder: (context, state) => state.maybeMap(
          failed: always(
            SwapError(
              onRetry: _onRetry,
              operation: widget.operation,
            ),
          ),
          finished: always(
            SwapSuccess(
              swapOperation: widget.operation,
            ),
          ),
          orElse: always(
            const SwapProgress(),
          ),
        ),
      );
}

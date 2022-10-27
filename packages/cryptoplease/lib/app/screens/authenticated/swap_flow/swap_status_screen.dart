import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/status/swap_error.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/status/swap_progress.dart';
import 'package:cryptoplease/app/screens/authenticated/swap_flow/components/status/swap_success.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/features/swap/bl/swap_verifier/bloc.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  void initState() {
    super.initState();
    context
        .read<SwapVerifierBloc>()
        .add(SwapVerifierEvent.swapRequested(jupiterRoute: widget.route));
  }

  void _onRetry() {
    context
        .read<SwapVerifierBloc>()
        .add(const SwapVerifierEvent.retryRequested());
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SwapVerifierBloc, SwapVerifierState>(
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

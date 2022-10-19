import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/swap/bl/swap_verifier/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/content_padding.dart';
import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class SwapTokenProcessScreen extends StatelessWidget {
  const SwapTokenProcessScreen({
    Key? key,
    required this.route,
  }) : super(key: key);

  final JupiterRoute route;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => SwapVerifierBloc(
          jupiterAggregatorClient: sl<JupiterAggregatorClient>(),
          myAccount: context.read<MyAccount>(),
          solanaClient: sl<SolanaClient>(),
        )..add(SwapVerifierEvent.swapRequested(jupiterRoute: route)),
        child: BlocBuilder<SwapVerifierBloc, SwapVerifierState>(
          builder: (context, state) => Scaffold(
            body: state.maybeMap(
              finished: (_) => const Text('Success!'),
              orElse: () => SwapStepWidget(
                isLoading: state.isProcessing,
                message: state.maybeMap(
                  preparing: (_) => 'preparing',
                  settingUp: (_) => 'settingUp',
                  swapping: (_) => 'swapping',
                  cleaningUp: (_) => 'cleaningUp',
                  failed: (s) => 'failed: $s',
                  orElse: () => context.l10n.loading,
                ),
                onRetry: state.mapOrNull<VoidCallback?>(
                  failed: (s) {
                    void retry() => context
                        .read<SwapVerifierBloc>()
                        .add(const SwapVerifierEvent.retryRequested());

                    return s.error.mapOrNull(
                      setupFailed: (_) => retry,
                      swapFailed: (_) => retry,
                      cleanupFailed: (_) => retry,
                      other: (_) => retry,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
}

extension on SwapVerifierState {
  bool get isProcessing => maybeMap(finished: F, failed: F, orElse: T);
}

class SwapStepWidget extends StatefulWidget {
  const SwapStepWidget({
    Key? key,
    required this.isLoading,
    required this.message,
    this.onRetry,
  }) : super(key: key);

  final String message;
  final bool isLoading;
  final VoidCallback? onRetry;

  @override
  State<SwapStepWidget> createState() => _SwapStepWidgetState();
}

class _SwapStepWidgetState extends State<SwapStepWidget> {
  @override
  Widget build(BuildContext context) => CpContentPadding(
        child: Center(
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              Text(widget.message),
              if (widget.onRetry != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 250),
                    child: CpButton(
                      text: context.l10n.retry,
                      onPressed: widget.onRetry,
                    ),
                  ),
                )
            ],
          ),
        ),
      );
}

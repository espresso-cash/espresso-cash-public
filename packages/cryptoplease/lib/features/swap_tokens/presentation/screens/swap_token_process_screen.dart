import 'package:cryptoplease/app/components/common_success.dart';
import 'package:cryptoplease/core/accounts/bl/account.dart';
import 'package:cryptoplease/features/swap_tokens/bl/transaction/swap_transaction_bloc.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/components/swap_error_dialog.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/components/swap_step_widget.dart';
import 'package:cryptoplease/l10n/l10n.dart';
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
        create: (context) => SwapTransactionBloc(
          jupiterAggregatorClient: context.read<JupiterAggregatorClient>(),
          myAccount: context.read<MyAccount>(),
          solanaClient: context.read<SolanaClient>(),
        )..add(SwapTransactionEvent.swapRequested(jupiterRoute: route)),
        child: BlocBuilder<SwapTransactionBloc, SwapTransactionState>(
          builder: (context, state) => Scaffold(
            body: state.maybeMap(
              finished: (_) => CommonSuccess(
                text: context.l10n.swapSuccess,
                onClosePressed: null,
              ),
              orElse: () => SwapStepWidget(
                isLoading: state.isProcessing,
                message: state.maybeMap(
                  preparing: (_) => context.l10n.swapPreparing,
                  settingUp: (_) => context.l10n.swapSetup,
                  swapping: (_) => context.l10n.swapTransaction,
                  cleaningUp: (_) => context.l10n.swapCleanup,
                  failed: (s) => s.error.buildMessage(context),
                  orElse: () => context.l10n.loading,
                ),
                onRetry: state.mapOrNull<VoidCallback?>(
                  failed: (s) {
                    void retry() => context
                        .read<SwapTransactionBloc>()
                        .add(const SwapTransactionEvent.retryRequested());

                    return s.error.mapOrNull(
                      setupFailed: (_) => retry,
                      swapFailed: (_) => retry,
                      cleanupFailed: (_) => retry,
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
}

extension on SwapTransactionState {
  bool get isProcessing => maybeMap(finished: F, failed: F, orElse: T);
}

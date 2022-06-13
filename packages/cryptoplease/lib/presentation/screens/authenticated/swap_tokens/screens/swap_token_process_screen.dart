import 'package:cryptoplease/bl/swap_tokens/transaction/swap_transaction_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/common_success.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/swap_error_dialog.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/swap_step_widget.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwapTokenProcessScreen extends StatefulWidget {
  const SwapTokenProcessScreen({Key? key}) : super(key: key);

  @override
  SwapTokenOrderScreenState createState() => SwapTokenOrderScreenState();
}

class SwapTokenOrderScreenState extends State<SwapTokenProcessScreen> {
  late final SwapTransactionBloc swapTransactionBloc;

  @override
  void initState() {
    super.initState();
    swapTransactionBloc = context.read<SwapTransactionBloc>();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SwapTransactionBloc, SwapTransactionState>(
        bloc: swapTransactionBloc,
        builder: (context, state) => Scaffold(
          appBar: CpAppBar(),
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
                  void retry() => swapTransactionBloc
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
      );
}

extension on SwapTransactionState {
  bool get isProcessing => maybeMap(finished: F, failed: F, orElse: T);
}

import 'package:cryptoplease/bl/swap_tokens/transaction/swap_transaction_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/common_success.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/swap_error_dialog.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/swap_step_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/swap_token_router.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwapTokenProcessScreen extends StatefulWidget {
  const SwapTokenProcessScreen({Key? key}) : super(key: key);

  @override
  _SwapTokenOrderScreenState createState() => _SwapTokenOrderScreenState();
}

class _SwapTokenOrderScreenState extends State<SwapTokenProcessScreen> {
  late final SwapTransactionBloc swapTransactionBloc;

  @override
  void initState() {
    super.initState();
    swapTransactionBloc = context.read<SwapTransactionBloc>();
  }

  void _onFinish() => context.read<SwapTokenRouter>().closeFlow();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SwapTransactionBloc, SwapTransactionState>(
        bloc: swapTransactionBloc,
        builder: (context, state) => CpTheme.dark(
          child: Scaffold(
            appBar: CpAppBar(
              leading: BackButton(
                onPressed: () => context.read<SwapTokenRouter>().closeFlow(),
              ),
            ),
            body: SafeArea(
              child: state.maybeMap(
                finished: (f) => CpTheme.dark(
                  child: CommonSuccess(
                    text: context.l10n.swapSuccess,
                    onClosePressed: _onFinish,
                  ),
                ),
                orElse: () => SwapStepWidget(
                  isLoading: state.isProcessing,
                  message: state.maybeMap(
                    preparing: (s) => context.l10n.swapPreparing,
                    settingUp: (s) => context.l10n.swapSetup,
                    swapping: (s) => context.l10n.swapTransaction,
                    cleaningUp: (s) => context.l10n.swapCleanup,
                    failed: (s) => s.reason.buildMessage(context),
                    orElse: () => context.l10n.loading,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

extension on SwapTransactionState {
  bool get isProcessing => maybeMap(
        finished: (_) => false,
        failed: (_) => false,
        orElse: () => true,
      );
}

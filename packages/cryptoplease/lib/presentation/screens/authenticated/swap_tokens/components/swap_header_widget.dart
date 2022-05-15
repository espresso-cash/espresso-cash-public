import 'package:cryptoplease/bl/swap_tokens/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/input_widgets/input_row_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/invert_swap_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwapHeaderWidget extends StatelessWidget {
  const SwapHeaderWidget({
    Key? key,
    required this.inputController,
    required this.outputController,
    required this.onSelectInput,
    required this.onSelectOutput,
  }) : super(key: key);

  final TextEditingController inputController;
  final TextEditingController outputController;
  final VoidCallback onSelectInput;
  final VoidCallback onSelectOutput;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SwapSelectorBloc, SwapSelectorState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputRowWidget(
                    label: context.l10n.youPay,
                    selectedToken: state.selectedInput,
                    onSelectToken: onSelectInput,
                    amountController: inputController,
                    isInputEnabled: true,
                    onMaxRequested: () => context.read<SwapSelectorBloc>().add(
                          const SwapSelectorEvent.maxInputRequested(),
                        ),
                  ),
                  const SizedBox(height: 32),
                  InputRowWidget(
                    label: context.l10n.youReceive,
                    selectedToken: state.selectedOutput,
                    onSelectToken: onSelectOutput,
                    isLoadingAmount: state.routeProcessingState.isProcessing,
                    amountController: outputController,
                    isInputEnabled: false,
                    isLoadingTokens: state.tokenProcessingState.maybeMap(
                      processing: (_) => state.outputTokens.isNotEmpty,
                      orElse: () => false,
                    ),
                  ),
                ],
              ),
              Positioned.fill(
                top: 24,
                bottom: 0,
                child: InvertSwapButton(
                  onTap: () => context.read<SwapSelectorBloc>().add(
                        const SwapSelectorEvent.swapInverted(),
                      ),
                ),
              ),
            ],
          ),
        ),
      );
}

import 'package:cryptoplease/features/swap_tokens/bl/selector/swap_selector_bloc.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/components/input_widgets/input_row_widget.dart';
import 'package:cryptoplease/features/swap_tokens/presentation/components/invert_swap_button.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwapHeaderWidget extends StatelessWidget {
  const SwapHeaderWidget({
    Key? key,
    required this.inputController,
    required this.output,
    required this.onSelectInput,
    required this.onSelectOutput,
    required this.onMaxRequested,
  }) : super(key: key);

  final TextEditingController inputController;
  final String output;
  final VoidCallback onSelectInput;
  final VoidCallback onSelectOutput;
  final VoidCallback onMaxRequested;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<SwapSelectorBloc, SwapSelectorState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ValueListenableBuilder<TextEditingValue>(
                    valueListenable: inputController,
                    builder: (context, value, child) => InputRowWidget(
                      label: context.l10n.youPay,
                      selectedToken: state.input,
                      onSelectToken: onSelectInput,
                      value: value.text,
                      onMaxRequested: onMaxRequested,
                    ),
                  ),
                  const SizedBox(height: 32),
                  InputRowWidget(
                    label: context.l10n.youReceive,
                    selectedToken: state.output,
                    onSelectToken: onSelectOutput,
                    isLoadingAmount: state.isLoadingRoute,
                    value: output,
                  ),
                ],
              ),
              const Positioned.fill(
                top: 24,
                bottom: 0,
                child: InvertSwapButton(),
              ),
            ],
          ),
        ),
      );
}

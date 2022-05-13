import 'package:cryptoplease/bl/tokens/token.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/input_widgets/amount_input_widget.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/token_dropdown.dart';
import 'package:flutter/material.dart';

class InputRowWidget extends StatelessWidget {
  const InputRowWidget({
    Key? key,
    required this.label,
    required this.selectedToken,
    required this.onSelectToken,
    required this.amountController,
    required this.isEnabled,
    this.onMaxRequested,
  }) : super(key: key);

  final String label;
  final Token? selectedToken;
  final VoidCallback onSelectToken;
  final TextEditingController amountController;
  final bool isEnabled;
  final VoidCallback? onMaxRequested;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase()),
          const SizedBox(height: 4),
          SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: TokenDropdown(
                    selectedToken: selectedToken,
                    onTap: onSelectToken,
                  ),
                ),
                const SizedBox(width: 12),
                Flexible(
                  child: AmountInputWidget(
                    onMaxRequested: onMaxRequested,
                    amountController: amountController,
                    isEnabled: isEnabled,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

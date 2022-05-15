import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/input_widgets/custom_selection_handle.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class AmountInputWidget extends StatelessWidget {
  const AmountInputWidget({
    Key? key,
    required this.amountController,
    required this.isEnabled,
    required this.onMaxRequested,
    required this.suffixWidget,
  }) : super(key: key);

  final VoidCallback? onMaxRequested;
  final bool isEnabled;
  final TextEditingController amountController;
  final Widget? suffixWidget;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          color: CpColors.darkPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Center(
          child: TextFormField(
            controller: amountController,
            readOnly: true,
            showCursor: isEnabled,
            cursorColor: CpColors.yellowColor,
            selectionControls: CustomColorSelectionHandle(
              CpColors.yellowColor,
            ),
            style: const TextStyle(fontSize: 24),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: suffixWidget,
            ),
          ),
        ),
      );
}

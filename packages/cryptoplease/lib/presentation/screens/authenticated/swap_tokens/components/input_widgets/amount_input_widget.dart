import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class AmountInputWidget extends StatelessWidget {
  const AmountInputWidget({
    Key? key,
    required this.amountController,
    required this.onMaxRequested,
    required this.suffixWidget,
  }) : super(key: key);

  final VoidCallback? onMaxRequested;
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
            showCursor: false,
            style: const TextStyle(fontSize: 24),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: suffixWidget,
            ),
          ),
        ),
      );
}

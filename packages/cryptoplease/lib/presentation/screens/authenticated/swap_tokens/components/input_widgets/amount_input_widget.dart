import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/screens/authenticated/swap_tokens/components/input_widgets/custom_selection_handle.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class AmountInputWidget extends StatefulWidget {
  const AmountInputWidget({
    Key? key,
    required this.amountController,
    required this.isEnabled,
    required this.onMaxRequested,
  }) : super(key: key);

  final VoidCallback? onMaxRequested;
  final bool isEnabled;
  final TextEditingController amountController;

  @override
  _AmountInputWidgetState createState() => _AmountInputWidgetState();
}

class _AmountInputWidgetState extends State<AmountInputWidget> {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          color: CpColors.darkPrimaryColor,
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: Center(
          child: TextFormField(
            controller: widget.amountController,
            readOnly: true,
            showCursor: widget.isEnabled,
            cursorColor: CpColors.yellowColor,
            selectionControls: CustomColorSelectionHandle(
              CpColors.yellowColor,
            ),
            style: const TextStyle(fontSize: 24),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: widget.onMaxRequested == null
                  ? null
                  : TextButton(
                      onPressed: widget.onMaxRequested,
                      child: Text(
                        context.l10n.max.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
              // Material(
              //     shape: const CircleBorder(),
              //     color: CpColors.darkPrimaryColor,
              //     child: IconButton(
              //       onPressed: widget.onMaxRequested,
              //       icon: Text(context.l10n.max.toUpperCase()),
              //     ),
              //   ),
            ),
          ),
        ),
      );
}

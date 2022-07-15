import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

class SlippageDropdown extends StatelessWidget {
  SlippageDropdown({
    Key? key,
    required this.currentSlippage,
    required this.onSlippageChanged,
  }) : super(key: key);

  final Decimal currentSlippage;
  final ValueSetter<Decimal> onSlippageChanged;

  final _availableSlippages = [
    0.1,
    0.5,
    1.0,
  ].map((v) => Decimal.parse(v.toString()));

  @override
  Widget build(BuildContext context) => Material(
        color: CpColors.darkPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: DropdownButtonFormField<Decimal>(
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                gapPadding: 0,
              ),
            ),
            value: currentSlippage,
            onChanged: (value) {
              if (value == null) return;
              onSlippageChanged(value);
            },
            items: _availableSlippages
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$value %',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

import 'package:flutter/material.dart';

const _availableSlippages = [0.1, 0.5, 1.0];

class SlippageDropdown extends StatelessWidget {
  const SlippageDropdown({
    Key? key,
    required this.currentSlippage,
    required this.onSlippageChanged,
  }) : super(key: key);

  final double currentSlippage;
  final ValueSetter<double> onSlippageChanged;

  @override
  Widget build(BuildContext context) => Material(
        child: DropdownButton<double>(
          items: _availableSlippages
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text('$value %'),
                ),
              )
              .toList(),
          value: currentSlippage,
          onChanged: (value) {
            if (value == null) return;
            onSlippageChanged(value);
          },
          underline: const SizedBox.shrink(),
        ),
      );
}

import 'package:flutter/material.dart';

import '../../../ui/amount_keypad/keypad_key.dart';

class PinKeypad extends StatelessWidget {
  const PinKeypad({
    super.key,
    required this.maxDigits,
    required TextEditingController controller,
    this.heightFactor = 0.5,
    this.hasDacimalSeparator = false,
  }) : _controller = controller;

  final TextEditingController _controller;
  final int maxDigits;
  final double heightFactor;
  final bool hasDacimalSeparator;

  static const _keys = [
    KeypadKey.number(number: 1),
    KeypadKey.number(number: 2),
    KeypadKey.number(number: 3),
    KeypadKey.number(number: 4),
    KeypadKey.number(number: 5),
    KeypadKey.number(number: 6),
    KeypadKey.number(number: 7),
    KeypadKey.number(number: 8),
    KeypadKey.number(number: 9),
    KeypadKey.decimalSeparator(),
    KeypadKey.number(number: 0),
    KeypadKey.backspace(),
  ];

  static const _keys2 = [
    KeypadKey.number(number: 1),
    KeypadKey.number(number: 2),
    KeypadKey.number(number: 3),
    KeypadKey.number(number: 4),
    KeypadKey.number(number: 5),
    KeypadKey.number(number: 6),
    KeypadKey.number(number: 7),
    KeypadKey.number(number: 8),
    KeypadKey.number(number: 9),
    KeypadKey.empty(),
    KeypadKey.number(number: 0),
    KeypadKey.backspace(),
  ];

  void _handleKeyTapped(String key) {
    String value = _controller.text;
    if (key == '<') {
      if (value.isNotEmpty) {
        value = value.substring(0, value.length - 1);
      } else {
        value = '';
      }
    } else {
      value = '$value$key';
    }

    if (value.length > maxDigits) {
      value = value.substring(0, value.length - 1);
    }
    _controller.text = value;
  }

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.sizeOf(context).height * heightFactor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: 3 / 2,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: (hasDacimalSeparator ? _keys : _keys2)
                .map(
                  (KeypadKey child) => InkWell(
                    onTap: () => _handleKeyTapped(child.value),
                    child: Center(
                      child: child,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

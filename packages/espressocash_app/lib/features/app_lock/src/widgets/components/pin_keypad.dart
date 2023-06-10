import 'package:flutter/material.dart';

import '../../../../../ui/amount_keypad/keypad_key.dart';

class PinKeypad extends StatelessWidget {
  const PinKeypad({
    super.key,
    required this.maxDigits,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;
  final int maxDigits;

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
    KeypadKey.backspace(),
    KeypadKey.number(number: 0),
  ];

  void _manageKey(String key) {
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
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: 3 / 2,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: _keys
                .map(
                  (KeypadKey child) => InkWell(
                    onTap: () => _manageKey(child.value),
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

import 'package:cryptoplease/l10n/decimal_separator.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/presentation/components/keypad_key.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

class EnterAmountKeypad extends StatelessWidget {
  const EnterAmountKeypad({
    Key? key,
    required this.controller,
    required this.maxDecimals,
  }) : super(key: key);

  final TextEditingController controller;
  final int maxDecimals;

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
    KeypadKey.decimalSeparator()
  ];

  void _manageKey(String key, String decimalSeparator) {
    String value = controller.text;
    if (key == '<') {
      if (value.isNotEmpty) {
        value = value.substring(0, value.length - 1);
      }
    } else if (key == '.') {
      // If we already have it, ignore it
      if (value.contains(decimalSeparator)) {
        return;
      } else if (value.isEmpty) {
        value = '0$decimalSeparator';
      } else {
        value = '$value$decimalSeparator';
      }
    } else {
      if (value.isEmpty && key == '0') {
        value = '0$decimalSeparator';
      } else {
        value = '$value$key'.replaceFirst(RegExp('^[0]+'), '');
        if (value.startsWith(decimalSeparator)) {
          value = '0$value';
        }
      }
    }

    final decimals = value
        .split(decimalSeparator)
        .let((v) => v.length > 1 ? v[1] : '')
        .let((v) => v.length);

    if (decimals <= maxDecimals) {
      controller.text = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final decimalSeparator =
        getDecimalSeparator(DeviceLocale.localeOf(context));

    final size = MediaQuery.of(context).size.height / 2;

    return SizedBox(
      height: size,
      width: size,
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
                  onTap: () => _manageKey(child.value, decimalSeparator),
                  child: Center(child: child),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

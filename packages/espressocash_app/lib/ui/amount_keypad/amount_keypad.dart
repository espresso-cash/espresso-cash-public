import 'dart:math';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../l10n/decimal_separator.dart';
import '../../l10n/device_locale.dart';
import 'keypad_key.dart';

class AmountKeypad extends StatelessWidget {
  const AmountKeypad({
    super.key,
    required this.controller,
    required this.maxDecimals,
    this.height,
    this.width,
    this.isEnabled = true,
    this.padding = const EdgeInsets.all(16),
  });

  final TextEditingController controller;
  final int maxDecimals;
  final double? height;
  final double? width;
  final bool isEnabled;
  final EdgeInsets padding;

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

  void _manageKey(String key, String decimalSeparator) {
    String value = controller.text;
    if (key == '<') {
      if (value.isNotEmpty) {
        value = value.substring(0, value.length - 1);
      }
    } else if (key == '.') {
      // If we already have it, ignore it
      if (value.contains(decimalSeparator)) return;

      if (value.isEmpty) {
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
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final decimalSeparator =
              getDecimalSeparator(DeviceLocale.localeOf(context));

          final height =
              this.height ?? min(MediaQuery.sizeOf(context).height / 2, 400);
          final width = this.width ?? min(height, constraints.maxWidth);

          final childAspectRatio = 4 / 3 * width / height;

          return SizedBox(
            height: width,
            width: height,
            child: Padding(
              padding: padding,
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                childAspectRatio: childAspectRatio,
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                children: _keys
                    .map(
                      (KeypadKey child) => Opacity(
                        opacity: isEnabled ? 1 : 0.5,
                        child: InkWell(
                          onTap: isEnabled
                              ? () => _manageKey(child.value, decimalSeparator)
                              : null,
                          child: Center(child: child),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      );
}

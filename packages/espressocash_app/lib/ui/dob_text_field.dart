import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'text_field.dart';

class CpDobTextField extends StatelessWidget {
  const CpDobTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    this.readonly = false,
  });

  final TextEditingController controller;
  final String placeholder;
  final bool readonly;

  @override
  Widget build(BuildContext context) => CpTextField(
    padding: const EdgeInsets.only(top: 18, bottom: 16, left: 26, right: 26),
    readOnly: readonly,
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp('[0-9-/]')),
      LengthLimitingTextInputFormatter(10),
      const _DateInputFormatter(),
    ],
    fontWeight: FontWeight.w500,
    fontSize: 16,
    controller: controller,
    inputType: TextInputType.datetime,
    textInputAction: TextInputAction.next,
    backgroundColor: CpColors.lightGreyColor,
    placeholder: placeholder,
    placeholderColor: CpColors.greyColor,
    textColor: Colors.white,
  );
}

class _DateInputFormatter extends TextInputFormatter {
  const _DateInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue previousValue, TextEditingValue currentValue) {
    final String currentText = currentValue.text;

    final int currentLength = currentText.length;
    final int previousLength = previousValue.text.length;

    if (currentLength == 1) {
      if (int.tryParse(currentText) == null || int.parse(currentText) > 3) {
        return _updateText('');
      }
    }

    if (currentLength == 2 && previousLength == 1) {
      final int day = int.tryParse(currentText.substring(0, 2)) ?? 0;
      if (day < 1 || day > 31) {
        return _updateText(currentText.substring(0, 1));
      }

      return _updateText('$currentText/');
    }

    if (currentLength == 4) {
      if (int.tryParse(currentText.substring(3, 4)) == null ||
          int.parse(currentText.substring(3, 4)) > 1) {
        return _updateText(currentText.substring(0, 3));
      }
    }

    if (currentLength == 5 && previousLength == 4) {
      final int month = int.tryParse(currentText.substring(3, 5)) ?? 0;
      if (month < 1 || month > 12) {
        return _updateText(currentText.substring(0, 4));
      }

      return _updateText('$currentText/');
    }

    if ((currentLength == 3 && previousLength == 4) ||
        (currentLength == 6 && previousLength == 7)) {
      return _updateText(currentText.substring(0, currentLength - 1));
    }

    if (currentLength == 3 && previousLength == 2) {
      if (!currentText.contains('/')) {
        return _updateText('${currentText.substring(0, 2)}/${currentText.substring(2)}');
      }
    }

    if (currentLength == 6 && previousLength == 5) {
      if (!currentText.contains('/', 5)) {
        return _updateText('${currentText.substring(0, 5)}/${currentText.substring(5)}');
      }
    }

    if (currentLength == 7) {
      if (int.tryParse(currentText.substring(6, 7)) == null ||
          int.parse(currentText.substring(6, 7)) > 2) {
        return _updateText(currentText.substring(0, 6));
      }
    }

    if (currentLength == 8) {
      final int yearPrefix = int.tryParse(currentText.substring(6, 8)) ?? 0;
      if (yearPrefix < 19 || yearPrefix > 20) {
        return _updateText(currentText.substring(0, 7));
      }
    }

    return _updateText(currentText);
  }

  TextEditingValue _updateText(String text) =>
      TextEditingValue(text: text, selection: TextSelection.collapsed(offset: text.length));
}

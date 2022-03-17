import 'package:flutter/services.dart';

class MnemonicInputFormatter implements TextInputFormatter {
  final _regex = RegExp(r'\s+');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final phrase = newValue.text.toLowerCase().replaceAll(_regex, ' ');

    final selection = newValue.selection.end > phrase.length
        ? TextSelection.collapsed(
            offset: phrase.length,
            affinity: newValue.selection.affinity,
          )
        : newValue.selection;

    return newValue.copyWith(
      text: phrase,
      selection: selection,
    );
  }
}

// TODO(rhbrunetto): use this extension app-wide
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'snackbar.dart';

extension ClipboardExt on BuildContext {
  void copyToClipboard(String text) {
    final data = ClipboardData(text: text);
    Clipboard.setData(data);
    showClipboardSnackbar(this);
  }
}

import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../l10n/l10n.dart';
import '../../routing.dart';
import '../../ui/snackbar.dart';
import '../../ui/web_view_screen.dart';

extension LinkOpenerExt on BuildContext {
  Future<void> openLink(String link) async {
    try {
      final url = Uri.parse(link);
      await WebViewRoute((url: url, title: null, onLoaded: null))
          .push<void>(this);
    } on FormatException catch (_) {
      showCpErrorSnackbar(
        this,
        message: l10n.tryAgainLater,
      );
    }
  }
}

// TODO(rhbrunetto): use this extension app-wide
extension ClipboardExt on BuildContext {
  void copyToClipboard(String text) {
    final data = ClipboardData(text: text);
    Clipboard.setData(data);
    showClipboardSnackbar(this);
  }
}

// TODO(rhbrunetto): use this extension app-wide
extension StringExt on String {
  String toShortAddress() {
    if (length < 8) return this;

    return '${substring(this, 0, 4)}'
        '\u2026'
        '${substring(this, length - 4)}';
  }

  String withZeroWidthSpaces() =>
      splitMapJoin('', onMatch: (m) => '${m.group(0) ?? ''}\u200b');
}

import 'dart:async';

import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

VoidCallback debounce(VoidCallback callback, int delay) {
  Timer? timer;

  return () {
    timer?.cancel();
    timer = Timer(Duration(milliseconds: delay), callback);
  };
}

extension LinkOpenerExtension on BuildContext {
  Future<void> openLink(String link) async {
    try {
      await launch(link);
    } on PlatformException catch (_) {
      showCpErrorSnackbar(
        this,
        message: l10n.tryAgainLater,
      );
    }
  }
}

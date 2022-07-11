import 'dart:io';

import 'package:cryptoplease/config.dart';
import 'package:flutter/services.dart';

class InstallLinkManager {
  static const _platform =
      MethodChannel('com.pleasecrypto.flutter/installReferrer');

  Future<Uri?> getInstallReferrer() async {
    if (Platform.isIOS) {
      final uri = await Clipboard.getData('text/plain')
          .then((it) => it?.text ?? '')
          .then(Uri.tryParse);

      if (uri != null && uri.host.endsWith(cpLinkDomain)) {
        await Clipboard.setData(const ClipboardData(text: ''));

        return uri;
      }
    } else if (Platform.isAndroid) {
      final result = await _platform.invokeMethod<String>('getInstallReferrer');

      return Uri.tryParse(result ?? '');
    }
  }
}

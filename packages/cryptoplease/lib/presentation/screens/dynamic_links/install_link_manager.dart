import 'dart:io';

import 'package:cryptoplease/config.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstallLinkManager {
  static const String _key = 'InstallLinkManager.firstLaunch';
  static const _platform =
      MethodChannel('com.pleasecrypto.flutter/installReferrer');

  Future<Uri?> getInstallReferrer() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool(_key) ?? true;
    if (!isFirstLaunch) return null;

    await prefs.setBool(_key, false);

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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config.dart';

extension BuildContextExt on BuildContext {
  void launchPlayStore() => launchUrl(
        Uri.parse(
          'https://play.google.com/store/apps/details?id=$playstoreName',
        ),
      );

  void launchAppStore() => launchUrl(
        Uri.parse(
          'https://apps.apple.com/app/id$appstoreId',
        ),
      );

  void launchStore() => defaultTargetPlatform == TargetPlatform.iOS
      ? launchAppStore()
      : launchPlayStore();
}

bool get isMobile =>
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.android;

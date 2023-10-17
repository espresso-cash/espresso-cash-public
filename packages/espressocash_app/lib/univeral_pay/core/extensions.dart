import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

bool get isMobile =>
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.android;

extension BuildContextEtx on BuildContext {
  bool get isSmall => MediaQuery.sizeOf(this).width <= 550;
}

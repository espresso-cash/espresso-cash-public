import 'package:flutter/foundation.dart';

bool get isMobile =>
    defaultTargetPlatform == TargetPlatform.iOS ||
    defaultTargetPlatform == TargetPlatform.android;

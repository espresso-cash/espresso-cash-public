import 'package:flutter/material.dart';

extension BuildContextEtx on BuildContext {
  bool get isSmall => MediaQuery.sizeOf(this).width < 380;
}

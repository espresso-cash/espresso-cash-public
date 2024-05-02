import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  void openFirstScreen() => Navigator.of(this, rootNavigator: true)
      .popUntil((route) => route.isFirst);
}

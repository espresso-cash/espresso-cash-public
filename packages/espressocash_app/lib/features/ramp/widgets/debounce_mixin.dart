import 'dart:async';
import 'package:flutter/material.dart';

const kDebounceDuration = Duration(milliseconds: 300);

mixin DebounceMixin<T extends StatefulWidget> on State<T> {
  Timer? _debounceTimer;

  @protected
  void debounce(VoidCallback action) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(kDebounceDuration, action);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

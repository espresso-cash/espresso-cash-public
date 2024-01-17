import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/foundation.dart';

extension ListenableExt<T extends Listenable> on T {
  Stream<T> toStream() {
    final controller = StreamController<T>();
    VoidCallback? listener;

    controller
      ..onListen = () {
        try {
          listener = (() => controller.add(this)).also(addListener);
        } on Object {
          controller.close();
        }
      }
      ..onCancel = () {
        if (listener == null) {
          // addListener thrown error.
          return;
        }

        try {
          listener?.let(removeListener);
          listener = null;
        } on Object {
          // ignore
        }
      };

    return controller.stream;
  }
}

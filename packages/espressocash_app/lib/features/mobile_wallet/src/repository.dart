import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'models/notification.dart';

typedef NotificationHanlder = FutureOr<Object?> Function(
  MobileWalletNotification notification,
);

@lazySingleton
class MobileWalletRepository extends ChangeNotifier {
  MobileWalletNotification? _notification;
  Completer<Object?>? _completer;

  Future<void> processNotification(
    NotificationHanlder onNotification,
  ) async {
    final notification = _notification;
    if (notification == null) return;

    final result = await onNotification(notification);

    notification.whenOrNull(
      request: (_) => _completeRequest(result),
    );
  }

  FutureOr<T?> notifyApp<T>(MobileWalletNotification notification) {
    _notification = notification;
    notifyListeners();

    return notification.whenOrNull<Future<T?>>(
      request: (_) => _waitForRequestComplete<T>(),
    );
  }

  void _completeRequest(Object? result) {
    _completer?.complete(result);
    _notification = null;
    notifyListeners();
  }

  Future<T?> _waitForRequestComplete<T>() {
    _cancelCurrentRequest();
    final c = Completer<T?>();
    _completer = c;

    return c.future;
  }

  void _cancelCurrentRequest() {
    final completer = _completer;
    if (completer != null && !completer.isCompleted) {
      completer.complete(null);
    }
    _completer = null;
  }
}

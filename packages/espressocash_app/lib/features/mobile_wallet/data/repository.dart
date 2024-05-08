import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../../accounts/auth_scope.dart';
import '../models/notification.dart';

typedef NotificationHanlder = FutureOr<Object?> Function(
  MobileWalletNotification notification,
);

@Singleton(scope: authScope)
class MobileWalletRepository extends ChangeNotifier implements Disposable {
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

  Future<T?> notifyApp<T>(MobileWalletNotification notification) async {
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

  @override
  void onDispose() => dispose();
}

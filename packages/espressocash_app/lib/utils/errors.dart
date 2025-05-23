import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ec_client_dart/ec_client_dart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

extension ExceptionX on Exception {
  bool isConnectionError() {
    final exception = this;

    return exception is DioException && exception.error is SocketException;
  }
}

void reportError(dynamic error, [dynamic stackTrace]) {
  if (error is Exception && error.isConnectionError()) return;

  Sentry.captureException(error, stackTrace: stackTrace);
}

void reportWebViewError(dynamic error) {
  Sentry.captureException(
    error,
    stackTrace: StackTrace.current,
    withScope: (scope) {
      scope.setTag('error_source', 'webview');
    },
  );
}

void logMessage({
  required String message,
  required Map<String, dynamic>? data,
  SentryLevel level = SentryLevel.info,
}) {
  Sentry.captureMessage(
    message,
    level: level,
    withScope: (scope) => scope.setContexts('data', data ?? {}),
  );
}

extension DioErrorExt on Exception {
  EspressoCashError? toEspressoCashError() {
    try {
      final error = EspressoCashException.tryParse(this);

      return error?.error;
    } on Object {
      return null;
    }
  }
}

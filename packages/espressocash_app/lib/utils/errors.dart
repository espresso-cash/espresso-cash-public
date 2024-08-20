import 'dart:io';

import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
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

extension DioErrorExt on DioException {
  EspressoCashError? toEspressoCashError() {
    final data = response?.data;

    if (data is! Map<String, dynamic>) return null;

    try {
      final error = EspressoCashException.fromJson(data);

      return error.error;
    } on Object {
      return null;
    }
  }
}

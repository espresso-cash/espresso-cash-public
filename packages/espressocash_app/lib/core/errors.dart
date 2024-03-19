import 'dart:io';

import 'package:dio/dio.dart';
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

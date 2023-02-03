import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dio/dio.dart';

extension DioErrorExt on DioError {
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

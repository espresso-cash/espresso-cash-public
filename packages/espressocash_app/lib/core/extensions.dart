import 'package:dio/dio.dart';
import 'package:espressocash_api/espressocash_api.dart';
import 'package:rxdart/rxdart.dart';

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

extension ValueStreamExt<T> on ValueStream<T> {
  (Stream<T>, T) withInitial() => (this, value);
}

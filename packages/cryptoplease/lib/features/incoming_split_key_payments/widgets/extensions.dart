import 'package:cryptoplease_api/cryptoplease_api.dart';
import 'package:dio/dio.dart';

extension DioErrorExt on DioError {
  bool get isInvalidEscrow {
    final data = response?.data;

    if (data is! Map<String, dynamic>) return false;

    try {
      final error = EspressoCashException.fromJson(data);

      return error.error == EspressoCashError.invalidEscrowAccount;
    } on Exception {
      return false;
    }
  }
}

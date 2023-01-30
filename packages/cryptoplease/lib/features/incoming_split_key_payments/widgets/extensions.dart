import 'package:dio/dio.dart';

extension DioErrorExt on DioError {
  bool get isAlreadyWithdrawn {
    final data = response?.data;

    if (data is! Map<String, dynamic>) return false;

    final error = data['err'];
    if (error is! String) return false;

    return error == 'AlreadyUsed';
  }
}

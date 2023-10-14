import 'package:dio/dio.dart';

import '../../../config.dart';

class UniversalPayRepository {
  const UniversalPayRepository(this.dio);

  final Dio dio;

  Future<String> fetch({
    required String receiver,
    required String reference,
  }) async {
    final data = {
      'solanaAddress': receiver,
      'solanaReference': reference,
    };

    final result =
        await dio.get<Map<String, dynamic>>(apiBaseUrl, queryParameters: data);

    return result.data!['result'] as String;
  }
}

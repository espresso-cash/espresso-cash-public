import 'package:dio/dio.dart';

import '../../../config.dart';

class UniversalPayRepository {
  const UniversalPayRepository(this.dio);

  final Dio dio;

  Future<String> fetch({
    required String destinationAddress,
    required String reference,
  }) async {
    final data = {
      'solanaAddress': destinationAddress,
      'solanaReference': reference,
    };

    final result =
        await dio.get<Map<String, dynamic>>(apiBaseUrl, queryParameters: data);

    return result.data!['result'] as String;
  }
}

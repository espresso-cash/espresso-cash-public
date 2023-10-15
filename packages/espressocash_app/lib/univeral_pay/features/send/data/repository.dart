import 'package:dio/dio.dart';

import '../../../config.dart';

class UniversalPayRepository {
  const UniversalPayRepository(this.dio);

  final Dio dio;

  Future<String> fetch({
    required String receiver,
    required String reference,
  }) async {
    final query = '$apiBaseUrl/generate/$receiver/$reference';

    final result = await dio.get<Map<String, dynamic>>(query);

    return result.data!['result'] as String;
  }
}

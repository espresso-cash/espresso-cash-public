import 'package:dio/dio.dart';

class UniversalPayRepository {
  const UniversalPayRepository(this.dio);

  final Dio dio;

  Future<String> fetch({
    required String destinationAddress,
    required String destinationAta,
    required String reference,
  }) async {
    final data = {
      'destinationAddress': destinationAddress,
      'destinationAta': destinationAta,
      'reference': reference,
    };

    print(data);
    //TODO fetch from firebase fn
    await Future.delayed(const Duration(seconds: 2));

    return '0x43b2595b3e6C200EBfd7F058dddF9403Ac457c1D';
  }
}

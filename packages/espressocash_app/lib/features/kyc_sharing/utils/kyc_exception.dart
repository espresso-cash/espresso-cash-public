import 'package:dio/dio.dart';

class KycException implements Exception {
  const KycException({required this.error});
  final KycError error;
}

enum KycError {
  invalidCode,
  invalidEmail,
  invalidPhone,
  invalidData,
  invalidToken,
  genericError,
}

extension ErrorExt on Exception {
  KycException toKycException() {
    if (this is! DioException) {
      return const KycException(error: KycError.genericError);
    }

    final dioException = this as DioException;
    final message = (dioException.response?.data
        as Map<String, dynamic>?)?['message'] as String?;

    return switch (message) {
      'invalid token' => const KycException(error: KycError.invalidToken),
      'invalid email' => const KycException(error: KycError.invalidEmail),
      'invalid phone' => const KycException(error: KycError.invalidPhone),
      'invalid code' => const KycException(error: KycError.invalidCode),
      'invalid data' => const KycException(error: KycError.invalidData),
      _ => const KycException(
          error: KycError.genericError,
        ),
    };
  }
}

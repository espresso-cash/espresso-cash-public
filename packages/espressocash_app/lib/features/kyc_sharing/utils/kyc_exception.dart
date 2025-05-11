// ignore_for_file: avoid-type-casts

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyc_exception.freezed.dart';

@freezed
sealed class KycException with _$KycException implements Exception {
  const factory KycException.invalidCode() = KycInvalidCode;
  const factory KycException.invalidEmail() = KycInvalidEmail;
  const factory KycException.invalidPhone() = KycInvalidPhone;
  const factory KycException.invalidData() = KycInvalidData;
  const factory KycException.invalidToken() = KycInvalidToken;
  const factory KycException.genericError() = KycGenericError;
  const factory KycException.phoneTooManyAttempts() = KycPhoneTooManyAttempts;
}

extension ErrorExt on Exception {
  KycException toKycException() {
    if (this is! DioException) {
      return const KycException.genericError();
    }

    final dioException = this as DioException;
    final message = (dioException.response?.data as Map<String, dynamic>?)?['message'] as String?;

    return switch (message) {
      'invalid token' => const KycException.invalidToken(),
      'invalid email' => const KycException.invalidEmail(),
      'invalid phone' => const KycException.invalidPhone(),
      'invalid code' => const KycException.invalidCode(),
      'invalid data' => const KycException.invalidData(),
      'too many verification attempts' => const KycException.phoneTooManyAttempts(),
      _ => const KycException.genericError(),
    };
  }
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../utils/errors.dart';

part 'kyc_exception.freezed.dart';

@freezed
sealed class KycException with _$KycException implements Exception {
  // Phone verification errors
  const factory KycException.phone(PhoneError error) = KycPhoneError;

  // Email verification errors
  const factory KycException.email(EmailError error) = KycEmailError;

  // Generic KYC errors
  const factory KycException.invalidToken() = KycInvalidToken;
  const factory KycException.invalidData() = KycInvalidData;
  const factory KycException.genericError() = KycGenericError;
  const factory KycException.invalid() = KycInvalid;
  const factory KycException.invalidCode() = KycInvalidCode;
}

enum PhoneError {
  blocked,
  fraudBlock,
  tooManyAttempts,
  undeliverable,
}

enum EmailError {
  blocked,
  bounced,
  spam,
}

extension ErrorExt on Exception {
  KycException toKycException() {
    if (this is! DioException) {
      reportError(this, StackTrace.current);

      return const KycException.genericError();
    }

    final dioException = this as DioException;
    final message = (dioException.response?.data
        as Map<String, dynamic>?)?['message'] as String?;
    final code =
        (dioException.response?.data as Map<String, dynamic>?)?['code'] as int?;

    if (message == null) {
      reportError(dioException, StackTrace.current);

      return const KycException.genericError();
    }

    // Phone-related Twilio errors
    if (code == 2) {
      final exception = switch (message) {
        final s when s.contains('60203') =>
          const KycException.phone(PhoneError.tooManyAttempts),
        final s when s.contains('60200') => const KycException.invalid(),
        final s when s.contains('60022') =>
          const KycException.phone(PhoneError.blocked),
        final s when s.contains('60033') =>
          const KycException.phone(PhoneError.undeliverable),
        final s when s.contains('60410') =>
          const KycException.phone(PhoneError.fraudBlock),
        _ => const KycException.genericError(),
      };

      if (exception is KycGenericError) {
        reportError(dioException, StackTrace.current);
      }

      return exception;
    }

    // Email and generic validation errors
    final exception = code == 400
        ? switch (message) {
            final s when s.contains('550 5.7.1') =>
              const KycException.email(EmailError.blocked),
            final s when s.contains('550 5.1.1') =>
              const KycException.email(EmailError.bounced),
            final s when s.contains('553 5.7.1') =>
              const KycException.email(EmailError.spam),
            _ => const KycException.genericError(),
          }
        : switch (message) {
            final s when s.contains('invalid token') =>
              const KycException.invalidToken(),
            final s when s.contains('invalid email') =>
              const KycException.invalid(),
            final s when s.contains('invalid phone') =>
              const KycException.invalid(),
            final s when s.contains('invalid code') =>
              const KycException.invalidCode(),
            final s when s.contains('invalid data') =>
              const KycException.invalidData(),
            _ => const KycException.genericError(),
          };

    if (exception is KycGenericError) {
      reportError(dioException, StackTrace.current);
    }

    return exception;
  }
}

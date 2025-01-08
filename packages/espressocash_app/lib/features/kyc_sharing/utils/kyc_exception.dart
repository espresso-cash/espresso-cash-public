import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../utils/errors.dart';

part 'kyc_exception.freezed.dart';

enum KycErrorType {
  // Auth
  invalidToken,
  invalidData,
  invalidCode,

  // Phone
  phoneBlocked,
  phoneFraudBlock,
  phoneTooManyAttempts,
  phoneUndeliverable,
  invalidPhone,

  // Email
  emailBlocked,
  emailBounced,
  emailSpam,
  emailUndeliverable,
  invalidEmail,

  // Document
  unverifiedContact,
  validationInProgress,
  smileIDJobNotCompleted,
  smileIDCannotUpload,

  // Fallback
  generic;
}

@freezed
sealed class KycException with _$KycException implements Exception {
  const factory KycException(
    KycErrorType type, {
    String? message,
  }) = _KycException;
}

extension ErrorExt on Exception {
  KycException toKycException() {
    if (this is! DioException) {
      reportError(this, StackTrace.current);

      return const KycException(KycErrorType.generic);
    }

    final message = (this as DioException).response?.data.toString();
    if (message == null) {
      reportError(this, StackTrace.current);

      return const KycException(KycErrorType.generic);
    }

    return KycException(
      switch (message) {
        // Authentication/Validation errors
        final s when s.contains('invalid token') => KycErrorType.invalidToken,
        final s when s.contains('invalid data') => KycErrorType.invalidData,
        final s when s.contains('invalid code') => KycErrorType.invalidCode,

        // Phone verification errors
        final s when s.contains('invalid phone') => KycErrorType.invalidPhone,
        final s when s.contains('phone number is blocked') =>
          KycErrorType.phoneBlocked,
        final s when s.contains('phone number blocked due to fraud') =>
          KycErrorType.phoneFraudBlock,
        final s when s.contains('too many verification attempts') =>
          KycErrorType.phoneTooManyAttempts,
        final s when s.contains('phone number is undeliverable') =>
          KycErrorType.phoneUndeliverable,

        // Email verification errors
        final s when s.contains('invalid email') => KycErrorType.invalidEmail,
        final s when s.contains('email address is blocked') =>
          KycErrorType.emailBlocked,
        final s when s.contains('email address has bounced') =>
          KycErrorType.emailBounced,
        final s when s.contains('email blocked due to spam') =>
          KycErrorType.emailSpam,
        final s when s.contains('email address is undeliverable') =>
          KycErrorType.emailUndeliverable,

        // Document validation errors
        final s when s.contains('email and phone must be verified') =>
          KycErrorType.unverifiedContact,
        final s when s.contains('validation already in progress') =>
          KycErrorType.validationInProgress,
        final s when s.contains('smileID job not completed') =>
          KycErrorType.smileIDJobNotCompleted,
        final s when s.contains('failed to upload') =>
          KycErrorType.smileIDCannotUpload,

        // Fallback
        _ => KycErrorType.generic
      },
      message: message,
    );
  }
}

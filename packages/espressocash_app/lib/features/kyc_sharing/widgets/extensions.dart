import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_exception.dart';

extension KycBuildContext on BuildContext {
  Future<bool> sendEmailVerification(
    BuildContext context, {
    required String email,
  }) =>
      runWithLoader<bool>(
        context,
        () async {
          try {
            await sl<KycSharingService>().initEmailVerification(email: email);

            return true;
          } on KycException catch (error) {
            if (!mounted) return false;

            final message = switch (error.type) {
              KycErrorType.invalidEmail => context.l10n.invalidEmail,
              KycErrorType.emailBlocked => context.l10n.emailBlocked,
              KycErrorType.emailBounced => context.l10n.emailBounced,
              KycErrorType.emailSpam => context.l10n.emailSpam,
              KycErrorType.emailUndeliverable =>
                context.l10n.emailUndeliverable,
              KycErrorType.phoneBlocked ||
              KycErrorType.phoneFraudBlock ||
              KycErrorType.phoneTooManyAttempts ||
              KycErrorType.phoneUndeliverable ||
              KycErrorType.unverifiedContact ||
              KycErrorType.validationInProgress ||
              KycErrorType.smileIDJobNotCompleted ||
              KycErrorType.smileIDCannotUpload ||
              KycErrorType.invalidToken ||
              KycErrorType.invalidData ||
              KycErrorType.invalidCode ||
              KycErrorType.invalidPhone ||
              KycErrorType.generic =>
                context.l10n.failedToSendVerificationCode,
            };

            showCpErrorSnackbar(context, message: message);

            return false;
          }
        },
      );

  Future<bool> sendPhoneVerification(
    BuildContext context, {
    required String phone,
  }) =>
      runWithLoader<bool>(
        context,
        () async {
          try {
            await sl<KycSharingService>().initPhoneVerification(phone: phone);

            return true;
          } on KycException catch (error) {
            if (!mounted) return false;

            final message = switch (error.type) {
              KycErrorType.invalidPhone => context.l10n.invalidPhone,
              KycErrorType.phoneBlocked => context.l10n.phoneBlocked,
              KycErrorType.phoneFraudBlock => context.l10n.phoneFraudBlock,
              KycErrorType.phoneTooManyAttempts =>
                context.l10n.phoneTooManyAttempts,
              KycErrorType.phoneUndeliverable =>
                context.l10n.phoneUndeliverable,
              KycErrorType.invalidToken ||
              KycErrorType.invalidData ||
              KycErrorType.emailBlocked ||
              KycErrorType.emailBounced ||
              KycErrorType.emailSpam ||
              KycErrorType.emailUndeliverable ||
              KycErrorType.unverifiedContact ||
              KycErrorType.validationInProgress ||
              KycErrorType.smileIDJobNotCompleted ||
              KycErrorType.smileIDCannotUpload ||
              KycErrorType.invalidEmail ||
              KycErrorType.invalidCode ||
              KycErrorType.generic =>
                context.l10n.failedToSendVerificationCode,
            };

            showCpErrorSnackbar(context, message: message);

            return false;
          }
        },
      );
}

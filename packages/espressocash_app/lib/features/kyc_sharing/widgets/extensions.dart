// ignore_for_file: avoid-wildcard-cases-with-enums

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

            final message = switch (error) {
              KycInvalidCode() => context.l10n.invalidEmail,
              KycEmailError(:final error) => switch (error) {
                  EmailError.blocked => 'context.l10n.emailBlocked',
                  EmailError.bounced => 'context.l10n.emailBounced',
                  EmailError.spam => 'context.l10n.emailSpam',
                },
              _ => context.l10n.failedToSendVerificationCode,
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

            final message = switch (error) {
              KycInvalidCode() => context.l10n.wrongVerificationCode,
              KycPhoneError(:final error) => switch (error) {
                  PhoneError.blocked => 'context.l10n.phoneBlocked',
                  PhoneError.fraudBlock => 'context.l10n.phoneFraudBlock',
                  PhoneError.tooManyAttempts =>
                    'context.l10n.phoneTooManyAttempts',
                  PhoneError.undeliverable => 'context.l10n.phoneUndeliverable',
                },
              _ => context.l10n.failedToSendVerificationCode,
            };

            showCpErrorSnackbar(context, message: message);

            return false;
          }
        },
      );
}

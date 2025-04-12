import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/loader.dart';
import '../../../ui/snackbar.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_exception.dart';

extension KycBuildContext on BuildContext {
  Future<bool> sendEmailVerification(BuildContext context, {required String email}) =>
      runWithLoader<bool>(context, () async {
        try {
          await sl<KycSharingService>().initEmailVerification(email: email);

          return true;
        } on KycException catch (error) {
          if (!mounted) return false;

          final message = switch (error) {
            KycInvalidEmail() => context.l10n.invalidEmail,
            KycInvalidCode() ||
            KycInvalidData() ||
            KycInvalidToken() ||
            KycInvalidPhone() ||
            KycPhoneTooManyAttempts() ||
            KycGenericError() => context.l10n.failedToSendVerificationCode,
          };

          showCpErrorSnackbar(context, message: message);

          return false;
        }
      });

  Future<bool> sendPhoneVerification(BuildContext context, {required String phone}) =>
      runWithLoader<bool>(context, () async {
        try {
          await sl<KycSharingService>().initPhoneVerification(phone: phone);

          return true;
        } on KycException catch (error) {
          if (!mounted) return false;

          final message = switch (error) {
            KycInvalidPhone() => context.l10n.invalidPhone,
            KycPhoneTooManyAttempts() => context.l10n.phoneTooManyAttempts,
            KycInvalidCode() ||
            KycInvalidEmail() ||
            KycInvalidData() ||
            KycInvalidToken() ||
            KycGenericError() => context.l10n.failedToSendVerificationCode,
          };

          showCpErrorSnackbar(context, message: message);

          return false;
        }
      });
}

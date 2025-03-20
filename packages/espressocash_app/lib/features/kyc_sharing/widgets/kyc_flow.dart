import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/snackbar.dart';
import '../models/kyc_validation_status.dart';
import '../screens/bank_account_screen.dart';
import '../screens/document_input_screen.dart';
import '../screens/email_confirmation_screen.dart';
import '../screens/email_status_screen.dart';
import '../screens/email_verification_screen.dart';
import '../screens/identity_verification_screen.dart';
import '../screens/kyc_description_screen.dart';
import '../screens/kyc_status_screen.dart';
import '../screens/personal_information_screen.dart';
import '../screens/phone_confirmation_screen.dart';
import '../screens/phone_status_screen.dart';
import '../screens/phone_verification_screen.dart';
import '../services/kyc_service.dart';
import '../services/pending_kyc_service.dart';
import '../utils/kyc_utils.dart';

typedef KycStepFunction = Future<bool?> Function(BuildContext ctx);

const List<KycStepFunction> kycSteps = [
  PersonalInformationScreen.push,
  IdentityVerificationScreen.push,
];

const List<KycStepFunction> emailSteps = [
  EmailVerificationScreen.push,
  EmailConfirmationScreen.push,
];

const List<KycStepFunction> phoneSteps = [
  PhoneVerificationScreen.push,
  PhoneConfirmationScreen.push,
];

List<KycStepFunction> documentSteps({
  required KycRequirement requirement,
}) =>
    [
      (BuildContext ctx) => DocumentInputScreen.push(
            ctx,
            requirement: requirement,
          ),
    ];

extension KycFlowExtension on BuildContext {
  Future<bool> openKycFlow({required String countryCode}) async {
    final user = sl<KycSharingService>().value;

    if (user == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return false;
    }

    final requirement = await sl<KycSharingService>().getKycRequirements(
      country: countryCode,
    );

    final kycStatus =
        await sl<PendingKycService>().fetchKycStatus(country: countryCode);

    final kycProcessed = kycStatus.isApprovedOrPending;

    if (!kycProcessed) {
      final success = await KycDescriptionScreen.push(this);

      sl<PendingKycService>().create();

      if (!success) return false;
    }

    final emailValidated = user.emailStatus == KycValidationStatus.approved;

    if (!emailValidated) {
      if (!await _runFlow(emailSteps)) return false;
    }

    final phoneValidated = user.phoneStatus == KycValidationStatus.approved;

    if (!phoneValidated) {
      if (!await _runFlow(phoneSteps)) return false;
    }

    final hasBankInfo =
        user.bankInfos?.any((account) => account.countryCode == countryCode) ==
            true;

    if (!hasBankInfo) {
      if (!await _navigateToScreen(BankAccountScreen.push)) return false;
    }

    // TODO(JE): update final flow
    if (!await _runFlow(documentSteps(requirement: requirement))) return false;

    if (!kycProcessed) {
      if (!await _runFlow(kycSteps)) return false;
    }

    if (kycStatus != KycValidationStatus.approved) {
      if (!await _navigateToScreen(
        (BuildContext ctx) => KycStatusScreen.push(
          ctx,
          country: countryCode,
        ),
      )) {
        return false;
      }
    }

    return true;
  }

  Future<bool> openEmailFlow() {
    final user = sl<KycSharingService>().value;

    return user?.emailStatus == KycValidationStatus.unverified
        ? _runFlow(emailSteps)
        : _navigateToScreen(EmailStatusScreen.push);
  }

  Future<bool> openPhoneFlow() {
    final user = sl<KycSharingService>().value;

    return user?.phoneStatus == KycValidationStatus.unverified
        ? _runFlow(phoneSteps)
        : _navigateToScreen(PhoneStatusScreen.push);
  }

  Future<bool> _runFlow(List<KycStepFunction> steps) async {
    for (final step in steps) {
      if (!await _navigateToScreen(step)) return false;
    }

    return true;
  }

  Future<bool> _navigateToScreen(KycStepFunction pushFunction) async {
    final success = await pushFunction(this);

    return success ?? false;
  }
}

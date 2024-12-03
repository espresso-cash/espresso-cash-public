import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/snackbar.dart';
import '../screens/bank_account_screen.dart';
import '../screens/basic_information_screen.dart';
import '../screens/email_confirmation_screen.dart';
import '../screens/email_status_screen.dart';
import '../screens/email_verification_screen.dart';
import '../screens/identity_verification_screen.dart';
import '../screens/kyc_description_screen.dart';
import '../screens/kyc_status_screen.dart';
import '../screens/phone_confirmation_screen.dart';
import '../screens/phone_status_screen.dart';
import '../screens/phone_verification_screen.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';

typedef KycStepFunction = Future<bool?> Function(BuildContext ctx);

const List<KycStepFunction> kycSteps = [
  BasicInformationScreen.push,
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

extension KycFlowExtension on BuildContext {
  Future<bool> openKycFlow() async {
    final user = sl<KycSharingService>().value;

    if (user == null) {
      showCpErrorSnackbar(this, message: l10n.tryAgainLater);

      return false;
    }

    final kycProcessed = user.kycStatus.isApprovedOrPending;

    if (!kycProcessed) {
      final success = await KycDescriptionScreen.push(this);
      if (!success) return false;
    }

    final emailValidated = user.emailStatus == ValidationStatus.approved;

    if (!emailValidated) {
      if (!await _runFlow(emailSteps)) return false;
    }

    final phoneValidated = user.phoneStatus == ValidationStatus.approved;

    if (!phoneValidated) {
      if (!await _runFlow(phoneSteps)) return false;
    }

    final hasBankInfo = user.hasBankInfo;

    if (!hasBankInfo) {
      if (!await _navigateToScreen(BankAccountScreen.push)) return false;
    }

    if (!kycProcessed) {
      if (!await _runFlow(kycSteps)) return false;
    }

    if (user.kycStatus != ValidationStatus.approved) {
      if (!await _navigateToScreen(KycStatusScreen.push)) return false;
    }

    return true;
  }

  Future<bool> openBasicInfoFlow() async {
    final user = sl<KycSharingService>().value;

    if (user?.kycStatus == ValidationStatus.unverified ||
        user?.kycStatus == ValidationStatus.unspecified) {
      return _runFlow(kycSteps);
    }

    return _navigateToScreen(KycStatusScreen.push);
  }

  Future<bool> openEmailFlow() async {
    final user = sl<KycSharingService>().value;

    if (user?.emailStatus == ValidationStatus.unverified ||
        user?.emailStatus == ValidationStatus.unspecified) {
      return _runFlow(emailSteps);
    }

    return _navigateToScreen(EmailStatusScreen.push);
  }

  Future<bool> openPhoneFlow() async {
    final user = sl<KycSharingService>().value;

    if (user?.phoneStatus == ValidationStatus.unverified ||
        user?.phoneStatus == ValidationStatus.unspecified) {
      return _runFlow(phoneSteps);
    }

    return _navigateToScreen(PhoneStatusScreen.push);
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

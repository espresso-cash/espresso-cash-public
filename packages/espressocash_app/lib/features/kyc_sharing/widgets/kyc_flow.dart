import 'package:flutter/material.dart';

import '../../../di.dart';
import '../screens/bank_account_screen.dart';
import '../screens/basic_information_screen.dart';
import '../screens/email_confirmation_screen.dart';
import '../screens/email_verification_screen.dart';
import '../screens/identity_verification_screen.dart';
import '../screens/kyc_camera_screen.dart';
import '../screens/phone_confirmation_screen.dart';
import '../screens/phone_verification_screen.dart';
import '../services/kyc_service.dart';

typedef KycStepFunction = Future<bool?> Function(BuildContext ctx);

const List<KycStepFunction> kycSteps = [
  BasicInformationScreen.push,
  IdentityVerificationScreen.push,
  KycCameraScreen.push,
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
    final service = sl<KycSharingService>().value;

    final List<KycStepFunction> steps = [];

    if (!service.hasPassedKyc) {
      steps
        ..addAll(kycSteps)
        ..add(BankAccountScreen.push);
    }

    if (!service.hasValidatedEmail) {
      steps.addAll(emailSteps);
    }

    if (!service.hasValidatedPhone) {
      steps.addAll(phoneSteps);
    }

    for (final step in kycSteps) {
      if (!await _navigateToScreen(step)) return false;
    }

    return true;
  }

  Future<bool> openBasicInfoFlow() async {
    for (final step in kycSteps) {
      if (!await _navigateToScreen(step)) return false;
    }

    return true;
  }

  Future<bool> openEmailFlow() async {
    for (final step in emailSteps) {
      if (!await _navigateToScreen(step)) return false;
    }

    return true;
  }

  Future<bool> openPhoneFlow() async {
    for (final step in phoneSteps) {
      if (!await _navigateToScreen(step)) return false;
    }

    return true;
  }

  Future<bool> _navigateToScreen(KycStepFunction pushFunction) async {
    final success = await pushFunction(this);

    return success ?? false;
  }
}

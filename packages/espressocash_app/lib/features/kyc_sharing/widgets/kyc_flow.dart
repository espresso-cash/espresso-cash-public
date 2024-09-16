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

    if (!service.hasPassedKyc) {
      if (!await openBasicInfoFlow()) return false;
      if (!await _navigateToScreen(BankAccountScreen.push)) return false;
    }

    if (!service.hasValidatedEmail) {
      if (!await openEmailFlow()) return false;
    }

    if (!service.hasValidatedPhone) {
      if (!await openPhoneFlow()) return false;
    }

    return true;
  }

  Future<bool> openBasicInfoFlow() => _runFlow(kycSteps);

  Future<bool> openEmailFlow() => _runFlow(emailSteps);

  Future<bool> openPhoneFlow() => _runFlow(phoneSteps);

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

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

extension KycFlowExtension on BuildContext {
  Future<bool> openKycFlow() async {
    final service = sl<KycSharingService>().value;

    final List<KycStepFunction> kycSteps = [];

    if (!service.hasPassedKyc) {
      kycSteps.addAll([
        BasicInformationScreen.push,
        IdentityVerificationScreen.push,
        KycCameraScreen.push,
        BankAccountScreen.push,
      ]);
    }

    if (!service.hasValidatedEmail) {
      kycSteps.addAll([
        EmailVerificationScreen.push,
        EmailConfirmationScreen.push,
      ]);
    }

    if (!service.hasValidatedPhone) {
      kycSteps.addAll([
        PhoneVerificationScreen.push,
        PhoneConfirmationScreen.push,
      ]);
    }

    for (final step in kycSteps) {
      if (!await _navigateToScreen(step)) return false;
    }

    return true;
  }

  Future<bool> _navigateToScreen(KycStepFunction pushFunction) async {
    final success = await pushFunction(this);

    return success ?? false;
  }
}

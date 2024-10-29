import 'package:flutter/material.dart';
import 'package:kyc_client_dart/kyc_client_dart.dart';

import '../../../di.dart';
import '../../ramp_partner/models/ramp_type.dart';
import '../screens/bank_account_screen.dart';
import '../screens/basic_information_screen.dart';
import '../screens/email_confirmation_screen.dart';
import '../screens/email_verification_screen.dart';
import '../screens/identity_verification_screen.dart';
import '../screens/kyc_camera_screen.dart';
import '../screens/kyc_description_screen.dart';
import '../screens/kyc_status_screen.dart';
import '../screens/phone_confirmation_screen.dart';
import '../screens/phone_verification_screen.dart';
import '../services/kyc_service.dart';
import '../utils/kyc_utils.dart';

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
  Future<bool> openKycFlow({required RampType rampType}) async {
    final service = sl<KycSharingService>().value;

    if (!await _navigateToScreen(
      (context) => KycDescriptionScreen.push(context, rampType),
    )) return false;

    final emailValidated = service?.emailStatus == ValidationStatus.approved;

    if (!emailValidated) {
      if (!await openEmailFlow()) return false;
    }

    final phoneValidated = service?.phoneStatus == ValidationStatus.approved;

    if (!phoneValidated) {
      if (!await openPhoneFlow()) return false;
    }

    final hasBankInfo = service?.hasBankInfo ?? false;

    if (!hasBankInfo) {
      if (!await _navigateToScreen(BankAccountScreen.push)) return false;
    }

    final kycProcessed = service?.kycStatus.isApprovedOrPending ?? false;

    if (!kycProcessed) {
      if (!await openBasicInfoFlow()) return false;
    }

    if (service?.kycStatus != ValidationStatus.approved) {
      if (!await _navigateToScreen(KycStatusScreen.push)) return false;
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

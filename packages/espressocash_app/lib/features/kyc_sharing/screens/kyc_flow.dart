import 'package:flutter/material.dart';

import '../../../di.dart';
import '../services/kyc_service.dart';
import 'basic_information_screen.dart';
import 'email_verification_screen.dart';
import 'phone_verification_screen.dart';

class KycFlow {
  static void open(BuildContext context) {
    final service = sl<KycSharingService>().value;

    if (!service.hasPassedKyc) {
      BasicInformationScreen.push(context);
    } else if (!service.hasValidatedEmail) {
      EmailVerificationScreen.push(context);
    } else if (!service.hasValidatedPhone) {
      PhoneVerificationScreen.push(context);
    }
  }
}

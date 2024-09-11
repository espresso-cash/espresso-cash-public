import 'package:flutter/material.dart';

import '../../../di.dart';
import '../data/kyc_repository.dart';
import 'basic_information_screen.dart';
import 'email_verification_screen.dart';
import 'phone_verification_screen.dart';

class KycFlow {
  static void open(BuildContext context) {
    final kycRepository = sl<KycRepository>();

    if (!kycRepository.hasValidatedEmail) {
      EmailVerificationScreen.push(context);
    } else if (!kycRepository.hasValidatedPhone) {
      PhoneVerificationScreen.push(context);
    } else if (!kycRepository.hasPassedKyc) {
      BasicInformationScreen.push(context);
    }
  }
}

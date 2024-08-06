import 'package:flutter/material.dart';

import '../../../di.dart';
import '../data/kyc_repository.dart';
import 'email_verification_screen.dart';
import 'kyc_details_screen.dart';
import 'phone_verification_screen.dart';
import 'read_pesmission_screen.dart';

class KycFlowScreen {
  static void open(BuildContext context) {
    final kycRepository = sl<KycRepository>();

    if (!kycRepository.hasValidatedEmail) {
      EmailVerificationScreen.push(context);
    } else if (!kycRepository.hasValidatedPhone) {
      PhoneVerificationScreen.push(context);
    } else if (!kycRepository.hasPassedKyc) {
      KycDetailsScreen.push(context);
    } else {
      ReadPermissionScreen.push(context);
    }
  }
}

import 'package:flutter/material.dart';

import 'email_verification_screen.dart';

class KycFlowScreen {
  static void open(BuildContext context) {
    // if(user email != verified)
    EmailVerificationScreen.push(context);
    // if(user phone != verified)
    //PhoneVerificationScreen.push(context);
    // (user kyc != data is not set)
    // KycDetailsScreen.push(context);
    // (user kyc != data is not verified)
    // KycConfirmationScreen.push(context);
  }
}

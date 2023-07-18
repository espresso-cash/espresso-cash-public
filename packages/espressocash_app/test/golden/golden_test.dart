import 'package:espressocash_app/features/onboarding/screens/no_email_and_password_screen.dart';
import 'package:espressocash_app/features/sign_in/screens/get_started_screen.dart';
import 'package:espressocash_app/features/wallet_flow/screens/wallet_flow_screen.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

void main() {
  testGoldensWidget(
    'Get started screen',
    GetStartedScreen(isSaga: false, onSignInPressed: () {}),
    skip: true, // Need to resolve issues with screenutil
  );

  testGoldensWidget(
    'No email and password screen',
    NoEmailAndPasswordScreen(onDone: () {}),
  );

  testGoldensWidget(
    'WalletFlowScreen',
    const Scaffold(body: WalletFlowScreen()),
  );
}

import 'package:espressocash_app/features/sign_in/screens/get_started_screen.dart';
import 'package:espressocash_app/features/wallet_flow/screens/wallet_screen.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

void main() {
  testGoldensWidget(
    'Get started screen',
    GetStartedScreen(
      onSignInPressed: () {},
      onLocalPressed: () {},
    ),
    skip: true, // Need to resolve issues with screenutil
  );

  testGoldensWidget(
    'WalletFlowScreen',
    const Scaffold(body: WalletScreen()),
  );
}

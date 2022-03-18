import 'package:cryptoplease/presentation/screens/sign_up/get_started_screen.dart';
import 'package:cryptoplease/presentation/screens/sign_up/no_email_and_password_screen.dart';
import 'package:cryptoplease/presentation/screens/split_key_payments/incoming/components/success_content.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils.dart';

void main() {
  testGoldensWidget('Get started screen', const GetStartedScreen());

  testGoldensWidget(
    'No email and password screen',
    const NoEmailAndPasswordScreen(),
  );

  group('SplitKeyIncomingPaymentScreen', () {
    testGoldensWidget(
      'SplitKeyIncomingPaymentScreen success',
      const SuccessContent(),
    );
  });
}

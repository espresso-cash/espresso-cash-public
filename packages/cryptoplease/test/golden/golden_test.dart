import 'package:cryptoplease/features/onboarding/presentation/get_started_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/no_email_and_password_screen.dart';

import 'utils.dart';

void main() {
  testGoldensWidget('Get started screen', const GetStartedScreen());

  testGoldensWidget(
    'No email and password screen',
    const NoEmailAndPasswordScreen(),
  );
}

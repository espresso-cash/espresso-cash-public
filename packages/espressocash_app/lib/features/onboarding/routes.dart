import 'package:auto_route/auto_route.dart';

import 'module.dart';
import 'src/widgets/create_profile_screen.dart';
import 'src/widgets/create_recovery_phrase_screen.dart';
import 'src/widgets/no_email_and_password_screen.dart';
import 'src/widgets/onboarding_flow_screen.dart';

const onboardingFlowRoutes = AutoRoute<void>(
  page: OnboardingFlowScreen,
  children: [
    AutoRoute<void>(
      page: NoEmailAndPasswordScreen,
      initial: true,
      guards: [RecoveryPhraseGuard],
    ),
    AutoRoute<void>(page: ViewRecoveryPhraseScreen),
    AutoRoute<void>(
      page: CreateProfileScreen,
      name: 'CreateProfileOnboardingScreen',
    ),
  ],
);

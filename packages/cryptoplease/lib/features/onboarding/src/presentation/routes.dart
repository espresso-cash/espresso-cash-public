import 'package:auto_route/auto_route.dart';

import 'create_profile_screen.dart';
import 'create_recovery_phrase_screen.dart';
import 'get_started_screen.dart';
import 'no_email_and_password_screen.dart';
import 'onboarding_flow_screen.dart';
import 'restore_account_screen.dart';

const signUpFlowRoutes = AutoRoute<void>(
  page: OnboardingFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: GetStartedScreen),
    AutoRoute<void>(page: NoEmailAndPasswordScreen),
    AutoRoute<void>(page: CreateRecoveryPhraseScreen),
    AutoRoute<void>(page: CreateProfileScreen),
    AutoRoute<void>(page: RestoreAccountScreen),
  ],
);

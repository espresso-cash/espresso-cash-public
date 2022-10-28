import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/onboarding/presentation/create_profile_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/create_recovery_phrase_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/get_started_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/no_email_and_password_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/onboarding_flow_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/restore_account_screen.dart';

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

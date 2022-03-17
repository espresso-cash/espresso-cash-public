import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/presentation/screens/legal/legal_document_view.dart';
import 'package:cryptoplease/presentation/screens/login/restore_account_screen.dart';
import 'package:cryptoplease/presentation/screens/sign_up/create_profile_screen.dart';
import 'package:cryptoplease/presentation/screens/sign_up/create_recovery_phrase_screen.dart';
import 'package:cryptoplease/presentation/screens/sign_up/get_started_screen.dart';
import 'package:cryptoplease/presentation/screens/sign_up/no_email_and_password_screen.dart';
import 'package:cryptoplease/presentation/screens/sign_up/sign_up_flow_screen.dart';

const signUpFlowRoutes = AutoRoute<void>(
  page: SignUpFlowScreen,
  children: [
    AutoRoute<void>(path: '', page: GetStartedScreen),
    AutoRoute<void>(page: NoEmailAndPasswordScreen),
    AutoRoute<void>(page: TermsOfServiceScreen),
    AutoRoute<void>(page: PrivacyPolicyScreen),
    AutoRoute<void>(page: CreateRecoveryPhraseScreen),
    AutoRoute<void>(page: CreateProfileScreen),
    AutoRoute<void>(page: RestoreAccountScreen),
  ],
);

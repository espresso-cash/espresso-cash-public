import 'package:auto_route/auto_route.dart';

import '../../ui/webview_screen.dart';
import 'src/widgets/get_started_screen.dart';
import 'src/widgets/restore_account_screen.dart';
import 'src/widgets/sign_in_flow_screen.dart';
import 'src/widgets/sign_in_profile_screen.dart';

const signUpFlowRoutes = AutoRoute<void>(
  page: SignInFlowScreen,
  children: [
    AutoRoute<void>(page: GetStartedScreen),
    AutoRoute<void>(page: RestoreAccountScreen),
    AutoRoute<void>(page: SignInProfileScreen),
    AutoRoute<void>(page: WebViewScreen),
  ],
);

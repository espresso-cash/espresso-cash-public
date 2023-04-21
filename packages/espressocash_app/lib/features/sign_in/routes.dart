import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';

import '../../ui/webview_screen.dart';
import 'src/widgets/create_wallet_screen.dart';
import 'src/widgets/get_started_screen.dart';
import 'src/widgets/restore_account_screen.dart';
import 'src/widgets/sign_in_flow_screen.dart';
import 'src/widgets/sign_in_profile_screen.dart';

const signUpFlowRoutes = AutoRoute<void>(
  page: SignInFlowScreen,
  children: [
    AutoRoute<void>(page: CreateWalletLoadingScreen),
    AutoRoute<void>(
      page: EmptyRouterPage,
      name: 'SignUpFlowRoute',
      children: [
        AutoRoute<void>(path: '', page: GetStartedScreen),
        AutoRoute<void>(page: RestoreAccountScreen),
        AutoRoute<void>(page: SignInProfileScreen),
        AutoRoute<void>(page: WebViewScreen),
      ],
    ),
  ],
);

import 'package:auto_route/auto_route.dart';

import '../../routes.gr.dart';

final signUpFlowRoutes = AutoRoute(
  page: SignInFlowRoute.page,
  children: [
    AutoRoute(path: '', page: GetStartedRoute.page),
    AutoRoute(page: RestoreAccountRoute.page),
    AutoRoute(page: SignInProfileRoute.page),
    AutoRoute(page: WebViewRoute.page),
  ],
);

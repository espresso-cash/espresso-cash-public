import 'package:auto_route/auto_route.dart';

import 'app/screens/authenticated/routes.dart';
import 'features/sign_in/routes.dart';
import 'ui/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute<void>(page: SplashScreen, initial: true),
    authenticatedFlowRoutes,
    signUpFlowRoutes,
  ],
)
class $AppRouter {
  const $AppRouter();
}

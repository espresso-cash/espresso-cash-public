import 'package:auto_route/auto_route.dart';

import '../features/onboarding/module.dart';
import '../ui/splash_screen.dart';
import 'screens/authenticated/routes.dart';

export 'package:cryptoplease/app/routes.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute<void>(page: SplashScreen, initial: true),
    authenticatedFlowRoutes,
    signUpFlowRoutes,
  ],
)
class $AppRouter {}

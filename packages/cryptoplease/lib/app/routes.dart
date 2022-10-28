import 'package:auto_route/auto_route.dart';

import '../features/onboarding/presentation/routes.dart';
import 'screens/authenticated/routes.dart';
import 'screens/splash_screen.dart';

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

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/screens/authenticated/routes.dart';
import 'package:cryptoplease/app/screens/splash_screen.dart';
import 'package:cryptoplease/features/onboarding/presentation/routes.dart';

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

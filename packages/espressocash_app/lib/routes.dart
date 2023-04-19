import 'package:auto_route/auto_route.dart';

import 'app/screens/authenticated/routes.dart';
import 'features/sign_in/routes.dart';
import 'routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  deferredLoading: false,
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, initial: true),
    authenticatedFlowRoutes,
    signUpFlowRoutes,
  ];
}

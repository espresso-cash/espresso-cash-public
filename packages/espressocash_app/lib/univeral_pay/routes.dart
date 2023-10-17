// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:auto_route/auto_route.dart';

import 'core/request_helpers.dart';
import 'routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Screen,Route',
  deferredLoading: false,
)
class AppRouter extends $AppRouter implements AutoRouteGuard {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (resolver.route.path.contains('request')) {
      final queryParams = resolver.route.queryParams;

      final isValid = queryParams.optString('amount') != null &&
          queryParams.optString('receiver') != null &&
          queryParams.optString('reference') != null;

      if (!isValid) {
        resolver.redirect(const RequestRoute());

        return;
      }
    } else if (resolver.route.path.contains('send')) {
      final uri = Uri.parse(html.window.location.toString());
      final request = tryParseUniversalPayRequest(uri);

      if (request == null) {
        resolver.redirect(const RequestRoute());

        return;
      }

      resolver.redirect(
        DisclaimerRoute(
          onAccept: () {
            resolver.next();
          },
        ),
      );

      return;
    }

    resolver.next();
  }

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: RequestRoute.page, path: '/', initial: true),
    AutoRoute(page: RequestLinkRoute.page, path: '/request'),
    AutoRoute(page: SenderInitialRoute.page, path: '/send'),
    AutoRoute(page: DisclaimerRoute.page, path: '/disclaimer'),
    AutoRoute(page: DemoRoute.page, path: '/videodemo'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

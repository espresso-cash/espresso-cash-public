// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:auto_route/auto_route.dart';

import 'core/disclaimer_service.dart';
import 'core/request_helpers.dart';
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
    AutoRoute(page: RequestRoute.page, path: '/', initial: true),
    AutoRoute(
      page: RequestLinkRoute.page,
      path: '/request',
      guards: const [RequestRouteGuard()],
    ),
    AutoRoute(
      page: SenderRouterRoute.page,
      path: '/send',
      guards: const [SendRouteGuard()],
      children: [
        AutoRoute(page: SenderInitialRoute.page, path: '', initial: true),
        AutoRoute(page: SolanaSendRoute.page, path: 'solana'),
        AutoRoute(page: OtherWalletRoute.page, path: 'other'),
      ],
    ),
    AutoRoute(
      page: DisclaimerRoute.page,
      path: '/disclaimer',
      keepHistory: false,
    ),
    AutoRoute(page: DemoRoute.page, path: '/videodemo'),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}

class RequestRouteGuard extends AutoRouteGuard {
  const RequestRouteGuard();
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final queryParams = resolver.route.queryParams;

    final isValid = queryParams.optString('amount') != null &&
        queryParams.optString('receiver') != null &&
        queryParams.optString('reference') != null;

    if (!isValid) {
      resolver.redirect(const RequestRoute());

      return;
    }

    resolver.next();
  }
}

class SendRouteGuard extends AutoRouteGuard {
  const SendRouteGuard();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final disclaimerService = DisclaimerService();

    final uri = Uri.parse(html.window.location.toString());
    final request = tryParseUniversalPayRequest(uri);

    if (request == null) {
      resolver.redirect(const RequestRoute());

      return;
    }

    if (!disclaimerService.hasAccepted) {
      resolver.redirect(
        DisclaimerRoute(
          onAccept: () {
            resolver.next();

            router.removeLast();
          },
        ),
      );

      return;
    }

    resolver.next();
  }
}

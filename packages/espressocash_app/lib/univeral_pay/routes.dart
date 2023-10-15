import 'package:auto_route/auto_route.dart';

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
    AutoRoute(
      page: RequestRouterRoute.page,
      path: '/',
      initial: true,
      children: [
        AutoRoute(page: RequestRoute.page, path: '', initial: true),
        AutoRoute(page: RequestLinkRoute.page, path: 'request'),
      ],
    ),
    AutoRoute(
      page: SenderRouterRoute.page,
      path: '/send',
      children: [
        AutoRoute(page: DisclaimerRoute.page, initial: true),
        AutoRoute(
          page: SenderInitialRoute.page,
          path: '',
        ),
        AutoRoute(
          page: SolanaSendRoute.page,
          path: 'solana',
        ),
        AutoRoute(
          page: OtherWalletRoute.page,
          path: 'other',
        ),
      ],
    ),
  ];
}

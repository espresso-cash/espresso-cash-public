import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_button.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeTabsScreen extends StatefulWidget {
  const HomeTabsScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  int _currentPage = 0;
  final _routerKey = GlobalKey<AutoRouterState>();

  void _onBottomNavigatorItemTap(int page) {
    setState(() => _currentPage = page);
    _routerKey.currentContext?.replaceRoute(_pages[page].route);
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentPage];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: page.overlayStyle,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: AutoRouter(key: _routerKey),
        bottomNavigationBar: CPNavigationBar(
          items: [
            NavigationButton(
              icon: Assets.icons.wallet,
              active: _currentPage == 0,
              onPressed: () => _onBottomNavigatorItemTap(0),
            ),
            NavigationButton(
              icon: Assets.icons.wallet,
              active: _currentPage == 1,
              onPressed: () => _onBottomNavigatorItemTap(1),
            ),
            NavigationButton(
              icon: Assets.icons.swap,
              active: _currentPage == 2,
              onPressed: () => _onBottomNavigatorItemTap(2),
            ),
            NavigationButton(
              icon: Assets.icons.notifications,
              active: _currentPage == 3,
              onPressed: () => _onBottomNavigatorItemTap(3),
            ),
            NavigationButton(
              icon: Assets.icons.profile,
              active: _currentPage == 4,
              onPressed: () => _onBottomNavigatorItemTap(4),
            ),
          ],
        ),
      ),
    );
  }
}

const _pages = [
  _Page(route: WalletRoute(), overlayStyle: SystemUiOverlayStyle.light),
  _Page(route: RequestPayRoute(), overlayStyle: SystemUiOverlayStyle.dark),
  _Page(
    route: SwapTokenFlowRoute(),
    overlayStyle: SystemUiOverlayStyle.dark,
  ),
  _Page(
    route: ActivitiesRoute(),
    overlayStyle: SystemUiOverlayStyle.dark,
  ),
  _Page(route: ProfileRoute(), overlayStyle: SystemUiOverlayStyle.dark),
];

class _Page {
  const _Page({
    required this.route,
    required this.overlayStyle,
  });

  final PageRouteInfo route;
  final SystemUiOverlayStyle overlayStyle;
}

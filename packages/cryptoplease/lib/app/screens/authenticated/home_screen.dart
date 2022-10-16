import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/ui/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/ui/navigation_bar/navigation_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            CpNavigationButton(
              icon: Assets.icons.profile,
              active: _currentPage == 0,
              onPressed: () => _onBottomNavigatorItemTap(0),
            ),
            CpNavigationButton(
              icon: Assets.icons.wallet,
              active: _currentPage == 1,
              onPressed: () => _onBottomNavigatorItemTap(1),
            ),
            CpNavigationButton(
              icon: Assets.icons.investments,
              active: _currentPage == 2,
              onPressed: () => _onBottomNavigatorItemTap(2),
            ),
            CpNavigationButton(
              icon: Assets.icons.notifications,
              active: _currentPage == 3,
              onPressed: () => _onBottomNavigatorItemTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

const _pages = [
  _Page(route: MenuRoute(), overlayStyle: SystemUiOverlayStyle.dark),
  _Page(route: WalletFlowRoute(), overlayStyle: SystemUiOverlayStyle.light),
  _Page(route: InvestmentsRoute(), overlayStyle: SystemUiOverlayStyle.light),
  _Page(route: ActivitiesRoute(), overlayStyle: SystemUiOverlayStyle.dark),
];

class _Page {
  const _Page({
    required this.route,
    required this.overlayStyle,
  });

  final PageRouteInfo route;
  final SystemUiOverlayStyle overlayStyle;
}

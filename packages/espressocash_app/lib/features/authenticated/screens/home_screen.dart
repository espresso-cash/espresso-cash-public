import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: navigationShell,
        bottomNavigationBar: ListenableBuilder(
          listenable: GoRouter.of(context).routeInformationProvider,
          builder: (context, child) => CPNavigationBar(
            items: _pages
                .mapIndexed(
                  (i, p) => CpNavigationButton(
                    icon: p.icon,
                    active: navigationShell.currentIndex == i,
                    onPressed: () {
                      navigationShell.goBranch(
                        i,
                        initialLocation: i == navigationShell.currentIndex,
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      );
}

class HomeShellRoute extends StatefulShellRouteData {
  const HomeShellRoute();

  @override
  Page<void> pageBuilder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      NoTransitionPage(child: HomeScreen(navigationShell: navigationShell));

  static const String $restorationScopeId = 'restorationScopeId';
}

final List<({SvgGenImage icon, String path})> _pages = [
  (
    path: '/home',
    icon: Assets.icons.home,
  ),
  (
    path: '/wallet',
    icon: Assets.icons.wallet,
  ),
  (
    path: '/activities',
    icon: Assets.icons.notifications,
  ),
];

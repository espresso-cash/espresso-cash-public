import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: child,
        bottomNavigationBar: ListenableBuilder(
          listenable: GoRouter.of(context).routeInformationProvider,
          builder: (context, child) => CPNavigationBar(
            items: _pages
                .mapIndexed(
                  (i, p) => CpNavigationButton(
                    icon: p.icon,
                    active: GoRouter.of(context)
                        .routeInformationProvider
                        .value
                        .uri
                        .path
                        .startsWith(p.path),
                    onPressed: () => context.go(p.path),
                  ),
                )
                .toList(),
          ),
        ),
      );
}

class HomeShellRoute extends ShellRouteData {
  const HomeShellRoute();

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) =>
      HomeScreen(child: navigator);
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

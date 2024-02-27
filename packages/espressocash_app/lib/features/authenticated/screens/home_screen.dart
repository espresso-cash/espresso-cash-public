import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.child});

  static const route = HomeRoute.new;

  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: child,
        bottomNavigationBar: CPNavigationBar(
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
      );
}

final _pages = [
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

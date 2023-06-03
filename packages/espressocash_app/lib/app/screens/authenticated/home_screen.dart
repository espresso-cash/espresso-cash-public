import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => AutoTabsRouter(
        routes: _pages.map((e) => e.route).toList(),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);

          return Scaffold(
            backgroundColor: Colors.white,
            extendBody: true,
            body: child,
            bottomNavigationBar: CPNavigationBar(
              items: _pages
                  .mapIndexed(
                    (i, p) => CpNavigationButton(
                      icon: p.icon,
                      active: tabsRouter.activeIndex == i,
                      onPressed: () {
                        if (tabsRouter.activeIndex == i) {
                          tabsRouter.popTop();
                        } else {
                          tabsRouter.setActiveIndex(i);
                        }
                      },
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
}

final _pages = [
  _Page(
    route: const InvestmentsRouter(),
    icon: Assets.icons.home,
  ),
  _Page(
    route: const WalletFlowRoute(),
    icon: Assets.icons.wallet,
  ),
  _Page(
    route: const ActivitiesRoute(),
    icon: Assets.icons.notifications,
  ),
];

@immutable
class _Page {
  const _Page({
    required this.route,
    required this.icon,
  });

  final PageRouteInfo route;
  final SvgGenImage icon;
}

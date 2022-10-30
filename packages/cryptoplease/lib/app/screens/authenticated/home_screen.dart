import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../gen/assets.gen.dart';
import '../../../routes.gr.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AutoTabsRouter(
        routes: _pages.map((e) => e.route).toList(),
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);
          final page = _pages[tabsRouter.activeIndex];

          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: page.overlayStyle,
            child: Scaffold(
              backgroundColor: Colors.white,
              extendBody: true,
              body: child,
              bottomNavigationBar: CPNavigationBar(
                items: _pages
                    .mapIndexed(
                      (i, p) => CpNavigationButton(
                        icon: p.icon,
                        active: tabsRouter.activeIndex == i,
                        onPressed: () => tabsRouter.setActiveIndex(i),
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      );
}

final _pages = [
  _Page(
    route: const MenuRoute(),
    overlayStyle: SystemUiOverlayStyle.dark,
    icon: Assets.icons.profile,
  ),
  _Page(
    route: const WalletFlowRoute(),
    overlayStyle: SystemUiOverlayStyle.light,
    icon: Assets.icons.wallet,
  ),
  _Page(
    route: const InvestmentsRoute(),
    overlayStyle: SystemUiOverlayStyle.light,
    icon: Assets.icons.investments,
  ),
  _Page(
    route: const ActivitiesRoute(),
    overlayStyle: SystemUiOverlayStyle.dark,
    icon: Assets.icons.notifications,
  ),
];

@immutable
class _Page {
  const _Page({
    required this.route,
    required this.overlayStyle,
    required this.icon,
  });

  final PageRouteInfo route;
  final SystemUiOverlayStyle overlayStyle;
  final SvgGenImage icon;
}

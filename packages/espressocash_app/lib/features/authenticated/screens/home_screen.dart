import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';
import '../../incoming_link_payments/widgets/pending_ilp_listener.dart';
import '../../outgoing_direct_payments/widgets/link_listener.dart';
import '../../ramp/partners/coinflow/widgets/coinflow_link_listener.dart';
import '../../transaction_request/widgets/otr_link_listener.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => ODPLinkListener(
        child: PendingILPListener(
          child: OTRLinkListener(
            child: CoinflowLinkListener(
              child: Scaffold(
                backgroundColor: Colors.white,
                extendBody: true,
                body: navigationShell,
                bottomNavigationBar: CPNavigationBar(
                  items: _pages
                      .mapIndexed(
                        (i, p) => CpNavigationButton(
                          icon: p.icon,
                          active: navigationShell.currentIndex == i,
                          onPressed: () {
                            navigationShell.goBranch(
                              i,
                              initialLocation:
                                  i == navigationShell.currentIndex,
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
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

  static const String $restorationScopeId = 'homeShellRoute';
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

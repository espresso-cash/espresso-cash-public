import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../gen/assets.gen.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';
import '../../activities/screens/activities_screen.dart';
import '../../incoming_link_payments/widgets/pending_ilp_listener.dart';
import '../../outgoing_direct_payments/widgets/link_listener.dart';
import '../../ramp/partners/coinflow/widgets/coinflow_link_listener.dart';
import '../../transaction_request/widgets/tr_link_listener.dart';
import '../../wallet_flow/screens/wallet_screen.dart';
import 'authenticated_flow_screen.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static void openWalletTab(BuildContext context) {
    AuthenticatedFlowScreen.backToHome(context);
    context.read<TabNotifier>().value = 1;
  }

  static void openActivitiesTab(
    BuildContext context, {
    ActivitiesTab tab = ActivitiesTab.pending,
  }) {
    AuthenticatedFlowScreen.backToHome(context);
    context.read<TabNotifier>().value = 2;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tabNotifier = TabNotifier();

  @override
  void dispose() {
    _tabNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _tabNotifier,
        child: ODPLinkListener(
          child: PendingILPListener(
            child: TRLinkListener(
              child: CoinflowLinkListener(
                child: ValueListenableBuilder(
                  valueListenable: _tabNotifier,
                  builder: (context, value, _) => Scaffold(
                    backgroundColor: Colors.white,
                    extendBody: true,
                    body: _pages[value].builder(context),
                    bottomNavigationBar: CPNavigationBar(
                      items: _pages
                          .mapIndexed(
                            (i, p) => CpNavigationButton(
                              icon: p.icon,
                              active: value == i,
                              onPressed: () => _tabNotifier.value = i,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

class TabNotifier extends ValueNotifier<int> {
  TabNotifier() : super(0);
}

final List<({SvgGenImage icon, String path, WidgetBuilder builder})> _pages = [
  (
    path: '/home',
    icon: Assets.icons.home,
    builder: (context) => const MainScreen(),
  ),
  (
    path: '/wallet',
    icon: Assets.icons.wallet,
    builder: (context) => const WalletScreen(),
  ),
  (
    path: '/activities',
    icon: Assets.icons.notifications,
    builder: (context) => const ActivitiesScreen(
          initialTab: ActivitiesTab.pending,
        ),
  ),
];

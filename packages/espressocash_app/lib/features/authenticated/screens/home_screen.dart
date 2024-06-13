import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../ui/loader.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/navigation_bar/navigation_button.dart';
import '../../../ui/page_spacer_wrapper.dart';
import '../../activities/screens/activities_screen.dart';
import '../../dynamic_links/services/dynamic_links_notifier.dart';
import '../../incoming_link_payments/widgets/pending_ilp_listener.dart';
import '../../outgoing_direct_payments/widgets/link_listener.dart';
import '../../ramp/partners/coinflow/widgets/coinflow_link_listener.dart';
import '../../transaction_request/widgets/tr_link_listener.dart';
import '../../wallet_flow/screens/wallet_screen.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static void openWalletTab(BuildContext context) {
    final _HomeScreenState? state =
        context.findAncestorStateOfType<_HomeScreenState>();
    if (state != null) {
      state._pageController.jumpToPage(1);
      state._tabNotifier.value = 1;
    }
  }

  static void openActivitiesTab(
    BuildContext context, {
    // ignore: avoid-unused-parameters, fix later
    ActivitiesTab tab = ActivitiesTab.pending,
  }) {
    final _HomeScreenState? state =
        context.findAncestorStateOfType<_HomeScreenState>();
    if (state != null) {
      state._pageController.jumpToPage(2);
      state._tabNotifier.value = 2;
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _tabNotifier = TabNotifier();
  final _pageController = PageController();

  @override
  void dispose() {
    _tabNotifier.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider.value(
        value: _tabNotifier,
        child: LinkLoader(
          child: ODPLinkListener(
            child: PendingILPListener(
              child: TRLinkListener(
                child: CoinflowLinkListener(
                  child: ValueListenableBuilder(
                    valueListenable: _tabNotifier,
                    builder: (context, value, _) => Scaffold(
                      backgroundColor: Colors.white,
                      extendBody: true,
                      body: PageView(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        children:
                            _pages.map((e) => e.builder(context)).toList(),
                      ),
                      bottomNavigationBar: CPNavigationBar(
                        items: _pages
                            .mapIndexed(
                              (i, p) => CpNavigationButton(
                                icon: p.icon,
                                active: value == i,
                                onPressed: () {
                                  _tabNotifier.value = i;
                                  _pageController.jumpToPage(i);
                                },
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
        ),
      );
}

class LinkLoader extends StatelessWidget {
  const LinkLoader({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
        listenable: sl<DynamicLinksNotifier>(),
        builder: (context, _) {
          final isLoading = sl<DynamicLinksNotifier>().loading;

          return CpLoader(
            isLoading: isLoading,
            child: child,
          );
        },
      );
}

class TabNotifier extends ValueNotifier<int> {
  TabNotifier() : super(0);
}

// ignore: avoid-function-type-in-records, fix later
final List<({SvgGenImage icon, WidgetBuilder builder})> _pages = [
  (
    icon: Assets.icons.home,
    builder: (context) => PageSpacerWrapper(
          child: MainScreen(
            onSendMoneyPressed: () => HomeScreen.openWalletTab(context),
            onTransactionsPressed: () => HomeScreen.openActivitiesTab(
              context,
              tab: ActivitiesTab.transactions,
            ),
          ),
        ),
  ),
  (
    icon: Assets.icons.wallet,
    builder: (context) => const WalletScreen(),
  ),
  (
    icon: Assets.icons.notifications,
    builder: (context) => ActivitiesScreen(
          initialTab: ActivitiesTab.pending,
          onSendMoneyPressed: () => HomeScreen.openWalletTab(context),
        ),
  ),
];

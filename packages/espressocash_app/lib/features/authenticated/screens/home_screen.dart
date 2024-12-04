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
import '../../ambassador/widgets/ambassador_link_listener.dart';
import '../../dynamic_links/services/dynamic_links_notifier.dart';
import '../../incoming_link_payments/widgets/pending_ilp_listener.dart';
import '../../outgoing_direct_payments/widgets/link_listener.dart';
import '../../ramp/partners/coinflow/widgets/coinflow_link_listener.dart';
import '../../transaction_request/widgets/tr_link_listener.dart';
import '../../wallet_flow/screens/wallet_screen.dart';
import 'main_screen.dart';

final _tabNotifier = ValueNotifier<int>(0);
final _activitiesTabNotifier =
    ValueNotifier<ActivitiesTab>(ActivitiesTab.pending);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static void openWalletTab(BuildContext context) {
    _tabNotifier.value = 1;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static void openActivitiesTab(
    BuildContext context, {
    ActivitiesTab tab = ActivitiesTab.pending,
  }) {
    _tabNotifier.value = 2;
    _activitiesTabNotifier.value = tab;
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabNotifier.addListener(_handleGlobalTabChange);
  }

  void _handleGlobalTabChange() {
    if (mounted) {
      _pageController.jumpToPage(_tabNotifier.value);
    }
  }

  @override
  void dispose() {
    _tabNotifier.removeListener(_handleGlobalTabChange);
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
                  child: AmbassadorLinkListener(
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
          initialTab: _activitiesTabNotifier.value,
          onSendMoneyPressed: () => HomeScreen.openWalletTab(context),
        ),
  ),
];

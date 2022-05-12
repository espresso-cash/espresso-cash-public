import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/activities/activities_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/presentation/screens/authenticated/components/navigation_bar/navigation_button.dart';
import 'package:cryptoplease/presentation/screens/authenticated/nft/nft_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/profile/profile_screen.dart';
import 'package:cryptoplease/presentation/screens/authenticated/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeTabsScreen extends StatefulWidget {
  const HomeTabsScreen({Key? key}) : super(key: key);

  @override
  State<HomeTabsScreen> createState() => _HomeTabsScreenState();
}

class _HomeTabsScreenState extends State<HomeTabsScreen> {
  int _currentPage = 0;

  void _onBottomNavigatorItemTap(int page) {
    setState(() => _currentPage = page);
  }

  @override
  Widget build(BuildContext context) {
    const pages = [
      _Page(widget: WalletScreen(), overlayStyle: SystemUiOverlayStyle.light),
      _Page(widget: NftScreen(), overlayStyle: SystemUiOverlayStyle.light),
      _Page(
        widget: ActivitiesScreen(),
        overlayStyle: SystemUiOverlayStyle.dark,
      ),
      _Page(widget: ProfileScreen(), overlayStyle: SystemUiOverlayStyle.dark),
    ];

    final page = pages[_currentPage];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: page.overlayStyle,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        body: page.widget,
        bottomNavigationBar: CPNavigationBar(
          items: [
            NavigationButton(
              icon: Assets.icons.wallet,
              active: _currentPage == 0,
              onPressed: () => _onBottomNavigatorItemTap(0),
            ),
            NavigationButton(
              icon: Assets.icons.nfts,
              active: _currentPage == 1,
              onPressed: () => _onBottomNavigatorItemTap(1),
            ),
            NavigationButton(
              icon: Assets.icons.notifications,
              active: _currentPage == 2,
              onPressed: () => _onBottomNavigatorItemTap(2),
            ),
            NavigationButton(
              icon: Assets.icons.profile,
              active: _currentPage == 3,
              onPressed: () => _onBottomNavigatorItemTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _Page {
  const _Page({
    required this.widget,
    required this.overlayStyle,
  });

  final Widget widget;
  final SystemUiOverlayStyle overlayStyle;
}

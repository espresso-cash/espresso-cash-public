import 'package:flutter/material.dart' hide Notification;

import '../../../../features/activities/module.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/navigation_bar/navigation_bar.dart';
import '../../../../ui/tab_bar.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insets = EdgeInsets.only(
      top: _padding,
      bottom: MediaQuery.of(context).padding.bottom,
    );

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: [
          CpAppBar(
            title: Text(context.l10n.activitiesTitle.toUpperCase()),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CpTabBar(
              tabs: [
                Tab(text: 'Pending'),
                Tab(text: 'Transactions'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _Wrapper(
                  child: PendingActivitiesList(padding: insets),
                ),
                _Wrapper(
                  child: TransactionList(padding: insets),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const double _padding = 40;

class _ComingSoon extends StatelessWidget {
  const _ComingSoon();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Assets.images.logoIcon.image(height: 101),
              const SizedBox(height: 21),
              const Text('Coming soon!'),
              const Spacer(),
              const SizedBox(height: cpNavigationBarheight),
            ],
          ),
        ),
      );
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          Container(
            height: _padding,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                ],
              ),
            ),
          ),
        ],
      );
}

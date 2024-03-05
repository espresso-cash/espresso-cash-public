import 'package:flutter/material.dart' hide Notification;
import 'package:go_router/go_router.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/page_fade_wrapper.dart';
import '../../../ui/tab_bar.dart';
import '../widgets/pending_activities_list.dart';
import '../widgets/transaction_list.dart';

enum ActivitiesTab { pending, transactions }

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({
    super.key,
    this.initialTab = ActivitiesTab.pending,
  });

  final ActivitiesTab? initialTab;

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    const insets = EdgeInsets.only(left: 8, right: 8, top: _padding);

    return PageFadeWrapper(
      child: DefaultTabController(
        length: 2,
        initialIndex: initialTab == ActivitiesTab.pending ? 0 : 1,
        child: Column(
          children: [
            CpAppBar(
              title: Text(context.l10n.activities_lblTitle.toUpperCase()),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CpTabBar(
                tabs: [
                  Tab(text: context.l10n.pending),
                  Tab(text: context.l10n.transactions),
                ],
              ),
            ),
            const Expanded(
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
            SizedBox(height: bottom),
          ],
        ),
      ),
    );
  }
}

class ActivitiesRoute extends GoRouteData {
  const ActivitiesRoute({this.initialTab});

  final ActivitiesTab? initialTab;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) =>
      NoTransitionPage(child: ActivitiesScreen(initialTab: initialTab));
}

const double _padding = 40;

class _Wrapper extends StatelessWidget {
  const _Wrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          child,
          const FadeGradient(
            height: _padding,
            direction: FadeGradientDirection.topDown,
          ),
        ],
      );
}

import 'package:cryptoplease/features/pending_activities/components/pending_activities_list.dart';
import 'package:cryptoplease/features/transaction/components/transaction_activities_list.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/app_bar.dart';
import 'package:cryptoplease/ui/tab_bar.dart';
import 'package:flutter/material.dart' hide Notification;

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insets = EdgeInsets.only(
      top: _padding,
      bottom: MediaQuery.of(context).padding.bottom,
    );

    return Scaffold(
      appBar: CpAppBar(
        title: Text(context.l10n.activitiesTitle.toUpperCase()),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
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
                    child: PendingActivitiesList(
                      padding: insets,
                    ),
                  ),
                  _Wrapper(
                    // TODO(KB): Replace with TransactionsList
                    child: TransactionActivitiesList(
                      padding: insets,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const double _padding = 40;

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

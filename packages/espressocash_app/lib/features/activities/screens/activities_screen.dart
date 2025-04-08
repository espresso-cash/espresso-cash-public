import 'package:flutter/material.dart' hide Notification;

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/colors.dart';
import '../../../ui/tab_bar.dart';
import '../../router/models/activities_tab.dart';
import '../widgets/pending_activities_list.dart';
import '../widgets/transaction_list.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key, required this.initialTab});

  final ActivitiesTab initialTab;

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> with SingleTickerProviderStateMixin {
  late final _controller = TabController(
    length: ActivitiesTab.values.length,
    initialIndex: widget.initialTab.index,
    vsync: this,
  );

  @override
  void didUpdateWidget(covariant ActivitiesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_controller.index != widget.initialTab.index) {
      _controller.animateTo(widget.initialTab.index);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    const insets = EdgeInsets.symmetric(horizontal: 24);

    Widget mapTab(ActivitiesTab tab) => Tab(
      text: switch (tab) {
        ActivitiesTab.pending => context.l10n.pending,
        ActivitiesTab.transactions => context.l10n.transactions,
      },
    );

    Widget mapWrapper(ActivitiesTab tab) => switch (tab) {
      ActivitiesTab.pending => const _Wrapper(child: PendingActivitiesList(padding: insets)),
      ActivitiesTab.transactions => const _Wrapper(child: TransactionList(padding: insets)),
    };

    return ColoredBox(
      color: CpColors.deepGreyColor,
      child: Column(
        children: [
          CpAppBar(title: Text(context.l10n.activities_lblTitle.toUpperCase())),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CpTabBar(
              controller: _controller,
              tabs: ActivitiesTab.values.map(mapTab).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _controller,
              children: ActivitiesTab.values.map(mapWrapper).toList(),
            ),
          ),
          SizedBox(height: bottom),
        ],
      ),
    );
  }
}

class _Wrapper extends StatelessWidget {
  const _Wrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      child,
      Align(
        alignment: Alignment.topCenter,
        child: Container(color: CpColors.deepGreyColor, height: 10),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(color: CpColors.deepGreyColor, height: 10),
      ),
    ],
  );
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/analytics/analytics_manager.dart';
import '../../../core/dynamic_links_notifier.dart';
import '../../../core/split_key_payments.dart';
import '../../../di.dart';
import '../data/pending_iskp_repository.dart';
import '../screens/first_part_qr_screen.dart';
import '../screens/first_part_ready_screen.dart';

class PendingISKPListener extends StatefulWidget {
  const PendingISKPListener({super.key, required this.child});

  final Widget child;

  @override
  State<PendingISKPListener> createState() => _PendingISKPListenerState();
}

class _PendingISKPListenerState extends State<PendingISKPListener> {
  @override
  void initState() {
    super.initState();
    _loadExisting();
  }

  Future<void> _loadExisting() async {
    final existing = await sl<PendingISKPRepository>().load();
    if (existing != null) {
      if (!mounted) return;

      _openFirstPartReadyScreen();
    }
  }

  void _openFirstPartReadyScreen() {
    context.router.push(
      FirstPartReadyScreen.route(
        onCancel: () => sl<PendingISKPRepository>().clear(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final firstPartLink = SplitKeyFirstLink.tryParse(link);
      if (firstPartLink != null) {
        switch (firstPartLink.source) {
          case SplitKeySource.qr:
            sl<AnalyticsManager>().firstLinkReceived();
            context.router.push(FirstPartQrScreen.route()).ignore();
          case SplitKeySource.other:
            sl<PendingISKPRepository>().save(firstPartLink);
            sl<AnalyticsManager>().firstLinkReceived();
            _openFirstPartReadyScreen();
        }

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

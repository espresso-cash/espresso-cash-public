import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/analytics/analytics_manager.dart';
import '../../../core/dynamic_links_notifier.dart';
import '../../../core/split_key_payments.dart';
import '../../../core/wallet.dart';
import '../../../di.dart';
import '../data/pending_iskp_repository.dart';
import '../screens/incoming_split_key_payment_screen.dart';
import 'extensions.dart';

class PendingISKPListener extends StatefulWidget {
  const PendingISKPListener({super.key, required this.child});

  final Widget child;

  @override
  State<PendingISKPListener> createState() => _PendingISKPListenerState();
}

class _PendingISKPListenerState extends State<PendingISKPListener> {
  Future<void> _processLink(SplitKeyFirstLink paymentData) async {
    final repository = sl<PendingISKPRepository>();

    final key = paymentData.key;

    final escrow = await walletFromKey(encodedKey: key);
    if (!mounted) return;

    final id = await context.createISKP(
      escrow: escrow,
      version: paymentData.apiVersion,
    );
    await repository.clear();

    if (!mounted) return;
    await context.router.push(
      IncomingSplitKeyPaymentScreen.route(id: id),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final firstPartLink = SplitKeyFirstLink.tryParse(link);

      if (firstPartLink != null) {
        sl<AnalyticsManager>().firstLinkReceived();
        _processLink(firstPartLink);

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

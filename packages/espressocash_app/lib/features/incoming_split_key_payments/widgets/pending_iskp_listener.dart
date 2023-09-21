import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/analytics/analytics_manager.dart';
import '../../../core/api_version.dart';
import '../../../core/dynamic_links_notifier.dart';
import '../../../core/link_payments.dart';
import '../../../core/wallet.dart';
import '../../../di.dart';
import '../screens/incoming_split_key_payment_screen.dart';
import 'extensions.dart';

class PendingISKPListener extends StatefulWidget {
  const PendingISKPListener({super.key, required this.child});

  final Widget child;

  @override
  State<PendingISKPListener> createState() => _PendingISKPListenerState();
}

class _PendingISKPListenerState extends State<PendingISKPListener> {
  Future<void> _processLink(LinkPayments paymentData) async {
    final key = paymentData.key;

    final escrow = await walletFromKey(encodedKey: key);
    if (!mounted) return;

    final id = await context.createISKP(
      escrow: escrow,
      version: SplitKeyApiVersion.smartContract,
    );

    if (!mounted) return;
    await context.router.push(
      IncomingSplitKeyPaymentScreen.route(id: id),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final payment = LinkPayments.tryParse(link);

      if (payment != null) {
        sl<AnalyticsManager>().firstLinkReceived();
        _processLink(payment);

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

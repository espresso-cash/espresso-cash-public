import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/analytics/analytics_manager.dart';
import '../../../core/dynamic_links_notifier.dart';
import '../../../core/link_payments.dart';
import '../../../core/wallet.dart';
import '../../../di.dart';
import '../screens/incoming_link_payment_screen.dart';
import 'extensions.dart';

class PendingILPListener extends StatefulWidget {
  const PendingILPListener({super.key, required this.child});

  final Widget child;

  @override
  State<PendingILPListener> createState() => _PendingILPListenerState();
}

class _PendingILPListenerState extends State<PendingILPListener> {
  Future<void> _processLink(LinkPayments paymentData) async {
    final key = paymentData.key;

    final escrow = await walletFromKey(encodedKey: key);
    if (!mounted) return;

    final id = await context.createILP(escrow: escrow);

    if (!mounted) return;
    await context.router.push(
      IncomingLinkPaymentScreen.route(id: id),
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

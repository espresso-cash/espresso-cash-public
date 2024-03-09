import 'package:flutter/material.dart';

import '../../../core/link_payments.dart';
import '../../../core/wallet.dart';
import '../../../di.dart';
import '../../../routing.dart';
import '../../analytics/analytics_manager.dart';
import '../../dynamic_links/widgets/dynamic_link_handler.dart';
import '../screens/incoming_link_payment_screen.dart';
import 'extensions.dart';

class PendingILPListener extends StatefulWidget {
  const PendingILPListener({super.key, required this.child});

  final Widget child;

  @override
  State<PendingILPListener> createState() => _PendingILPListenerState();
}

class _PendingILPListenerState extends State<PendingILPListener>
    with DynamicLinkHandler {
  Future<void> _processLink(LinkPayments paymentData) async {
    final key = paymentData.key;

    final escrow = await walletFromKey(encodedKey: key);
    if (!mounted) return;

    final id = await context.createILP(escrow: escrow);

    if (!mounted) return;
    IncomingLinkPaymentRoute(id).go(context);
  }

  @override
  bool handleDynamicLink(Uri uri) {
    final payment = LinkPayments.tryParse(uri);

    if (payment != null) {
      sl<AnalyticsManager>().firstLinkReceived();
      _processLink(payment);

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

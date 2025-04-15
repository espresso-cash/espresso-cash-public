import 'package:flutter/material.dart';

import '../../accounts/models/wallet.dart';
import '../../dynamic_links/widgets/dynamic_link_handler.dart';
import '../../link_payments/models/link_payment.dart';
import '../screens/incoming_link_payment_screen.dart';
import 'extensions.dart';

class PendingILPListener extends StatefulWidget {
  const PendingILPListener({super.key, required this.child});

  final Widget child;

  @override
  State<PendingILPListener> createState() => _PendingILPListenerState();
}

class _PendingILPListenerState extends State<PendingILPListener> with DynamicLinkHandler {
  Future<void> _processLink(LinkPayment paymentData) async {
    final key = paymentData.key;

    final escrow = await walletFromKey(encodedKey: key);
    if (!mounted) return;

    final id = await context.createILP(escrow: escrow);

    if (!mounted) return;
    IncomingLinkPaymentScreen.push(context, id: id);
  }

  @override
  bool handleDynamicLink(Uri uri) {
    final payment = LinkPayment.tryParse(uri);

    if (payment != null) {
      _processLink(payment);

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

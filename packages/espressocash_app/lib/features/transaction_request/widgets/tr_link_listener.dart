import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';

import '../../dynamic_links/widgets/dynamic_link_handler.dart';
import 'extensions.dart';

class TRLinkListener extends StatefulWidget {
  const TRLinkListener({super.key, required this.child});

  final Widget child;

  @override
  State<TRLinkListener> createState() => _TRLinkListenerState();
}

class _TRLinkListenerState extends State<TRLinkListener>
    with DynamicLinkHandler {
  @override
  bool handleDynamicLink(Uri uri) {
    final transactionRequest =
        SolanaTransactionRequest.tryParse(uri.toString());
    if (transactionRequest != null) {
      context.processSolanaTransactionRequest(transactionRequest);

      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';

import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/tip_payments.dart';
import '../../module.dart';

class TipLinkListener extends StatefulWidget {
  const TipLinkListener({super.key, required this.child});

  final Widget child;

  @override
  State<TipLinkListener> createState() => _TipLinkListenerState();
}

class _TipLinkListenerState extends State<TipLinkListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final tip = TipPaymentData.tryParse(link);

      if (tip != null) {
        context.processIT(tip);

        return true;
      }

      return false;
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

Future<Wallet> walletFromKey({
  required String encodedKey,
}) async {
  final key = ByteArray.fromBase58(encodedKey).toList();

  return Wallet.fromPrivateKeyBytes(privateKey: key);
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/analytics/analytics_manager.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/tip_payments.dart';
import '../../../../di.dart';
import '../../../../routes.gr.dart';
import '../bl/it_bloc.dart';

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
        _processIncomingTip(tip);

        return true;
      }

      return false;
    });
  }

  Future<void> _processIncomingTip(TipPaymentData tipPayment) async {
    final key = tipPayment.key;

    final escrow = await walletFromKey(encodedKey: key);

    final id = const Uuid().v4();

    sl<AnalyticsManager>().tipLinkReceived();

    if (!mounted) return;
    context.read<ITBloc>().add(ITEvent.create(escrow, id: id));
    await context.router.push(IncomingTipRoute(id: id));
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

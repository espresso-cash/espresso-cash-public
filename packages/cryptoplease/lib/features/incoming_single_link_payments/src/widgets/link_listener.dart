import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solana/encoder.dart';
import 'package:solana/solana.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/analytics/analytics_manager.dart';
import '../../../../core/dynamic_links_notifier.dart';
import '../../../../core/single_key_payments.dart';
import '../../../../di.dart';
import '../../../../routes.gr.dart';
import '../bl/islp_bloc.dart';

class ISLPListener extends StatefulWidget {
  const ISLPListener({super.key, required this.child});

  final Widget child;

  @override
  State<ISLPListener> createState() => _ISLPListenerState();
}

class _ISLPListenerState extends State<ISLPListener> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.watch<DynamicLinksNotifier>().processLink((link) {
      final tip = SingleKeyPaymentData.tryParse(link);

      if (tip != null) {
        _processIncomingTip(tip);

        return true;
      }

      return false;
    });
  }

  Future<void> _processIncomingTip(SingleKeyPaymentData tipPayment) async {
    final key = tipPayment.key;

    final escrow = await walletFromKey(encodedKey: key);

    final id = const Uuid().v4();

    sl<AnalyticsManager>().singleLinkReceived();

    if (!mounted) return;
    context.read<ISLPBloc>().add(ISLPEvent.create(escrow, id: id));
    await context.router.push(IncomingSingleLinkRoute(id: id));
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

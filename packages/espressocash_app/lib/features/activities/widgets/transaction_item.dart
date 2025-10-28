import 'package:flutter/material.dart';

import '../../../../di.dart';
import '../data/transaction_repository.dart';
import '../models/activity.dart';
import '../models/transaction.dart';
import 'common_tile.dart';
import 'odp_tile.dart';
import 'off_ramp_tile.dart';
import 'olp_tile.dart';
import 'on_ramp_tile.dart';
import 'outgoing_dln_tile.dart';
import 'payment_request_tile.dart';
import 'swap_tile.dart';
import 'tr_tile.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({super.key, required this.tx, this.showIcon = true});

  final String tx;
  final bool showIcon;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late final Stream<Transaction> _data;

  @override
  void initState() {
    super.initState();
    _data = sl<TransactionRepository>().watch(widget.tx);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<Transaction>(
    stream: _data,
    builder: (context, snapshot) {
      final tx = snapshot.data;
      if (tx == null) return const SizedBox.shrink();

      return tx.map(
        common: (t) => CommonTile(key: ValueKey(t.tx.id), txCommon: t, showIcon: widget.showIcon),
        activity: (txActivity) => switch (txActivity.activity) {
          (final OPRActivity it) => PaymentRequestTile(
            key: ValueKey(it.id),
            id: it.id,
            showIcon: widget.showIcon,
          ),
          (final ODPActivity it) => ODPTile(
            key: ValueKey(it.id),
            activity: it,
            showIcon: widget.showIcon,
          ),
          (final OLPActivity it) => OLPTile(
            key: ValueKey(it.id),
            activity: it,
            showIcon: widget.showIcon,
          ),
          (final OnRampActivity it) => OnRampTile(
            key: ValueKey(it.id),
            activity: it,
            showIcon: widget.showIcon,
          ),
          (final OffRampActivity it) => OffRampTile(
            key: ValueKey(it.id),
            activity: it,
            showIcon: widget.showIcon,
          ),
          (final OutgoingDlnPaymentActivity it) => OutgoingDlnTile(
            key: ValueKey(it.id),
            activity: it,
            showIcon: widget.showIcon,
          ),
          (final TransactionRequestActivity it) => TrTile(
            key: ValueKey(it.id),
            activity: it,
            showIcon: widget.showIcon,
          ),
          (final SwapActivity it) => SwapTile(
            key: ValueKey(it.id),
            activity: it,
            showIcon: widget.showIcon,
          ),
        },
      );
    },
  );
}

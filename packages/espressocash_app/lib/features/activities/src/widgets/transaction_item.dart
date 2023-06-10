import 'package:flutter/material.dart';

import '../../../../di.dart';
import '../../models/transaction.dart';
import '../transaction_repository.dart';
import 'common_tile.dart';
import 'odp_tile.dart';
import 'oskp_tile.dart';
import 'payment_request_tile.dart';
import 'swap_tile.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.tx,
  });

  final String tx;

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
            common: (t) => CommonTile(
              key: ValueKey(t.tx.id),
              txCommon: t,
            ),
            activity: (txActivity) => txActivity.activity.map(
              outgoingPaymentRequest: (p) => PaymentRequestTile(
                key: ValueKey(p.id),
                id: p.id,
              ),
              outgoingDirectPayment: (p) => ODPTile(
                key: ValueKey(p.id),
                activity: p,
              ),
              outgoingSplitKeyPayment: (p) => OSKPTile(
                key: ValueKey(p.id),
                activity: p,
              ),
              swap: (p) => SwapTile(
                key: ValueKey(p.id),
                activity: p,
              ),
            ),
          );
        },
      );
}

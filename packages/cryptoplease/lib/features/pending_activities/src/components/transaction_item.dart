import 'package:flutter/material.dart';

import '../transaction.dart';
import 'common_tile.dart';
import 'odp_tile.dart';
import 'oksp_tile.dart';
import 'payment_request_tile.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.tx,
  }) : super(key: key);

  final Transaction tx;

  @override
  Widget build(BuildContext context) => tx.map(
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
        ),
      );
}

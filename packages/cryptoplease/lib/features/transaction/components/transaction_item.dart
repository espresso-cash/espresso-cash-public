import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/pending_activities/components/odp_tile.dart';
import 'package:cryptoplease/features/pending_activities/components/oksp_tile.dart';
import 'package:cryptoplease/features/pending_activities/components/payment_request_tile.dart';
import 'package:cryptoplease/features/transaction/bl/transaction_fetched.dart';
import 'package:cryptoplease/features/transaction/components/common_tile.dart';
import 'package:cryptoplease/features/transaction/transaction.dart';
import 'package:cryptoplease/features/transaction/transaction_repository.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.txFetched,
  }) : super(key: key);

  final TransactionFetched txFetched;

  @override
  Widget build(BuildContext context) => FutureBuilder<Transaction>(
        future: sl<TransactionRepository>().match(txFetched),
        builder: (context, snapshot) {
          final transaction = snapshot.data;

          if (transaction == null) return const ListTile();

          return transaction.map(
            common: (t) => CommonTile(
              key: ValueKey(t.fetched.id),
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
        },
      );
}

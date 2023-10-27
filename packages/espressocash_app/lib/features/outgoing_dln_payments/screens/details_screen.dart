import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/utils.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import '../widgets/transfer_error.dart';

@RoutePage()
class OutgoingDlnPaymentDetailsScreen extends StatefulWidget {
  const OutgoingDlnPaymentDetailsScreen({
    super.key,
    required this.id,
  });

  static const route = OutgoingDlnPaymentDetailsRoute.new;

  final String id;

  @override
  State<OutgoingDlnPaymentDetailsScreen> createState() =>
      _OutgoingDlnPaymentDetailsScreenState();
}

class _OutgoingDlnPaymentDetailsScreenState
    extends State<OutgoingDlnPaymentDetailsScreen> {
  late final Stream<OutgoingDlnPayment?> _order;

  @override
  void initState() {
    super.initState();
    _order = sl<OutgoingDlnPaymentRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingDlnPayment?>(
        stream: _order,
        builder: (context, snapshot) {
          final order = snapshot.data;

          return order == null
              ? TransferProgress(onBack: () => context.router.pop())
              : switch (order.status) {
                  OutgoingDlnPaymentStatusSuccess(:final tx) ||
                  OutgoingDlnPaymentStatusFulfilled(:final tx) =>
                    () {
                      final content = order.status.maybeWhen(
                        success: (tx, orderId) => 'Transaction has been sent',
                        fulfilled: (tx, orderId) =>
                            'Transaction has been fulfilled',
                        orElse: () => '',
                      );

                      return TransferSuccess(
                        onBack: () => context.router.pop(),
                        onOkPressed: () => context.router.pop(),
                        statusContent: content,
                        onMoreDetailsPressed: () {
                          final link = tx.id
                              .let(createTransactionLink)
                              .let(Uri.parse)
                              .toString();
                          context.openLink(link);
                        },
                      );
                    }(),
                  OutgoingDlnPaymentStatusTxFailure(:final reason) =>
                    TransferError(
                      onBack: () => context.router.pop(),
                      reason: reason,
                    ),
                  _ => TransferProgress(
                      onBack: () => context.router.pop(),
                    ),
                };
        },
      );
}

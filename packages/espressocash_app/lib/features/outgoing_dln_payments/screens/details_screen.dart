import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/utils.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';

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
              : order.status.maybeMap(
                  fulfilled: (status) => TransferSuccess(
                    onBack: () => context.router.pop(),
                    onOkPressed: () => context.router.pop(),
                    statusContent: 'Transaction has been fulfilled!',
                    onMoreDetailsPressed: () {
                      final link = status.orderId
                          .let(_createDlnTransactionLink)
                          .let(Uri.parse)
                          .toString();
                      context.openLink(link);
                    },
                  ),
                  success: (status) => TransferSuccess(
                    onBack: () => context.router.pop(),
                    onOkPressed: () => context.router.pop(),
                    statusContent: 'Transaction has been sent!',
                    onMoreDetailsPressed: () {
                      final link = status.orderId
                          .let(_createDlnTransactionLink)
                          .let(Uri.parse)
                          .toString();
                      context.openLink(link);
                    },
                  ),
                  txFailure: (it) => TransferError(
                    onBack: () => context.router.pop(),
                    onRetry: () => {}, //TODO remove
                    reason: it.reason,
                  ),
                  orElse: () => TransferProgress(
                    onBack: () => context.router.pop(),
                  ),
                );
        },
      );
}

String _createDlnTransactionLink(String orderId) {
  final sb = StringBuffer()
    ..write('https://app.debridge.finance/order?orderId=')
    ..write(orderId);

  return sb.toString();
}

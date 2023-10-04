import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/utils.dart';
import '../../../di.dart';
import '../../../routes.gr.dart';
import '../../../ui/loader.dart';
import '../../accounts/models/account.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import '../services/odlnp_service.dart';

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
                  success: (status) => TransferSuccess(
                    onBack: () => context.router.pop(),
                    onOkPressed: () => context.router.pop(),
                    statusContent: 'Transaction has been sent!',
                    onMoreDetailsPressed: () {
                      final link = status.tx.id
                          .let(createTransactionLink)
                          .let(Uri.parse)
                          .toString();
                      context.openLink(link);
                    },
                  ),
                  txFailure: (it) => TransferError(
                    onBack: () => context.router.pop(),
                    onRetry: () => context.retryOrder(order),
                    reason: it.reason,
                  ),
                  orElse: () => TransferProgress(
                    onBack: () => context.router.pop(),
                  ),
                );
        },
      );
}

extension on BuildContext {
  Future<void> retryOrder(OutgoingDlnPayment payment) => runWithLoader(
        this,
        () => sl<OutgoingDlnPaymentService>().retry(
          payment,
          account: read<MyAccount>().wallet,
        ),
      );
}

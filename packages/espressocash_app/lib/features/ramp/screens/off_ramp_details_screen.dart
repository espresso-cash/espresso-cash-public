import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/utils.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/timeline.dart';
import '../../../core/presentation/format_date.dart';
import '../../../routes.gr.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_error.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../../transactions/widgets/transfer_success.dart';
import '../data/repository.dart';
import '../models/off_ramp_payment.dart';
import '../widgets/extensions.dart';

@RoutePage()
class OffRampDetailsScreen extends StatefulWidget {
  const OffRampDetailsScreen({
    super.key,
    required this.id,
    this.onSuccess,
  });

  static const route = OffRampDetailsRoute.new;

  final String id;
  final VoidCallback? onSuccess;

  @override
  State<OffRampDetailsScreen> createState() => _OffRampDetailsScreenState();
}

class _OffRampDetailsScreenState extends State<OffRampDetailsScreen> {
  late final Stream<OffRampPayment> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ORPRepository>().watch(widget.id);

    _payment.listen((e) {
      if (e.status is ORPStatusSuccess) {
        widget.onSuccess?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OffRampPayment>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;

          if (payment == null) {
            return TransferProgress(
              onBack: () => context.router.pop(),
            );
          }

          return payment.status.maybeMap(
            success: (status) => TransferSuccess(
              onBack: () => context.router.pop(),
              onOkPressed: () => context.router.pop(),
              statusContent: 'Cash out',
              content: CpTimeline(
                animated: false,
                status: CpTimelineStatus.success,
                active: 1,
                items: [
                  CpTimelineItem(title: context.l10n.transferInitiated),
                  CpTimelineItem(
                    title: 'Transaction Approved',
                    subtitle: context.formatDate(payment.created),
                  ),
                ],
              ),
              onMoreDetailsPressed: () {
                final link = status.txId
                    .let(createTransactionLink)
                    .let(Uri.parse)
                    .toString();
                context.openLink(link);
              },
            ),
            txFailure: (it) => TransferError(
              onBack: () => context.router.pop(),
              onRetry: () {
                context.retryORP(
                  payment: payment,
                  tx: it.tx,
                );
              },
              reason: it.reason,
            ),
            orElse: () => TransferProgress(
              onBack: () => context.router.pop(),
            ),
          );
        },
      );
}

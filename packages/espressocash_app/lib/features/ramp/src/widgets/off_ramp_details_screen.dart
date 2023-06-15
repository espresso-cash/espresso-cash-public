import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../core/transactions/create_transaction_link.dart';
import '../../../../di.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/timeline.dart';
import '../../../../ui/transfer_status/transfer_error.dart';
import '../../../../ui/transfer_status/transfer_progress.dart';
import '../../../../ui/transfer_status/transfer_success.dart';
import '../../models/off_ramp_payment.dart';
import '../../widgets/extensions.dart';
import '../bl/repository.dart';

@RoutePage()
class OffRampDetailsScreen extends StatefulWidget {
  const OffRampDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<OffRampDetailsScreen> createState() => _OffRampDetailsScreenState();
}

class _OffRampDetailsScreenState extends State<OffRampDetailsScreen> {
  late final Stream<OffRampPayment> _payment;

  @override
  void initState() {
    super.initState();
    _payment = sl<ORPRepository>().watch(widget.id);
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
              statusContent: context.l10n.outgoingTransferSuccess(
                payment.amount.format(DeviceLocale.localeOf(context)),
              ),
              content: CpTimeline(
                animated: false,
                status: CpTimelineStatus.success,
                active: 1,
                items: [
                  CpTimelineItem(title: context.l10n.transferInitiated),
                  CpTimelineItem(
                    title: context.l10n.receivedBy(
                      payment.receiver.toBase58().toShortAddress(),
                    ),
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
              onRetry: () => context.retryORP(payment: payment),
              reason: it.reason,
            ),
            orElse: () => TransferProgress(
              onBack: () => context.router.pop(),
            ),
          );
        },
      );
}

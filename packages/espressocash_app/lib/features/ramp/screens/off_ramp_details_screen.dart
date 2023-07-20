import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/utils.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/timeline.dart';
import '../../../core/presentation/format_date.dart';
import '../../../routes.gr.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../transactions/models/tx_sender.dart';
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

          // return payment.status.maybeMap(
          //   success: (status) => TransferSuccess(
          //     onBack: () => context.router.pop(),
          //     onOkPressed: () => context.router.pop(),
          //     statusContent: 'Cash out',
          //     content: CpTimeline(
          //       animated: false,
          //       status: CpTimelineStatus.success,
          //       active: 1,
          //       items: [
          //         CpTimelineItem(title: context.l10n.transferInitiated),
          //         CpTimelineItem(
          //           title: 'Transaction Approved',
          //           subtitle: context.formatDate(payment.created),
          //         ),
          //       ],
          //     ),
          //     onMoreDetailsPressed: () {
          //       final link = status.txId
          //           .let(createTransactionLink)
          //           .let(Uri.parse)
          //           .toString();
          //       context.openLink(link);
          //     },
          //   ),
          //   txFailure: (it) => TransferError(
          //     onBack: () => context.router.pop(),
          //     onRetry: () {
          //       context.retryORP(
          //         payment: payment,
          //         tx: it.tx,
          //       );
          //     },
          //     reason: it.reason,
          //   ),
          //   orElse: () => TransferProgress(
          //     onBack: () => context.router.pop(),
          //   ),
          // );

          final transferInitiated =
              CpTimelineItem(title: 'Withdrawal Initiated');
          final transferSent = CpTimelineItem(
            title: 'Withdrawal Sent',
            subtitle: context.formatDate(payment.created),
          );
          final withdrawSuccess = CpTimelineItem(
            title: 'Money Received in your account',
          );

          final items = [
            transferInitiated,
            transferSent,
            withdrawSuccess,
          ];

          final CpStatusType statusType = payment.status.map(
            txCreated: always(CpStatusType.info),
            txSent: always(CpStatusType.info),
            success: always(CpStatusType.info),
            withdrawn: always(CpStatusType.success),
            txFailure: always(CpStatusType.error),
          );

          final String statusContent = payment.status.map(
            txCreated: always(context.l10n.splitKeyTransactionLoading),
            txSent: always(context.l10n.splitKeyTransactionLoading),
            success: always('SUCCESS'), //TODO
            withdrawn: always('WITHDRAWN'), //TODO
            txFailure: (it) => [
              context.l10n.splitKeyErrorMessage2,
              if (it.reason == TxFailureReason.insufficientFunds)
                context.l10n.errorMessageInsufficientFunds
              else
                context.l10n.splitKeyErrorRetry,
            ].join(' '),
          );

          final CpTimelineStatus timelineStatus = payment.status.mapOrNull(
                success: always(CpTimelineStatus.inProgress),
                withdrawn: always(CpTimelineStatus.success),
                txFailure: always(CpTimelineStatus.failure),
              ) ??
              CpTimelineStatus.inProgress;

          final int activeItem = payment.status.map(
            txFailure: always(0),
            txCreated: always(0),
            txSent: always(1),
            success: always(2),
            withdrawn: always(3),
          );

          final animated = timelineStatus == CpTimelineStatus.inProgress;

          return StatusScreen(
            onBackButtonPressed: () => context.router.pop(),
            title: 'WITHDRAWAL PROGRESS',
            statusType: statusType,
            // statusTitle: statusTitle?.let(Text.new),
            statusContent: Text(statusContent),
            content: CpContentPadding(
              child: Column(
                children: [
                  const Spacer(flex: 1),
                  CpTimeline(
                    status: timelineStatus,
                    items: items,
                    active: activeItem,
                    animated: animated,
                  ),
                  const Spacer(flex: 4),
                  // ...actions,
                ],
              ),
            ),
          );
        },
      );
}

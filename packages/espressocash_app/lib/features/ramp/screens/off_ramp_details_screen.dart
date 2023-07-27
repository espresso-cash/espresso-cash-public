import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/utils.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/timeline.dart';
import '../../../core/presentation/format_date.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../../transactions/models/tx_sender.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../data/repository.dart';
import '../models/off_ramp_payment.dart';

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

          final transferInitiated =
              CpTimelineItem(title: context.l10n.withdrawalInitiated);
          final transferSent = CpTimelineItem(
            title: context.l10n.withdrawalSent,
            subtitle: context.formatDate(payment.created),
          );
          final withdrawSuccess = CpTimelineItem(
            title: context.l10n.withdrawalReceived,
            subtitle: payment.status.mapOrNull(
              success: always(context.l10n.withdrawalTimelineNotice),
              withdrawn: (s) {
                final timestamp = s.timestamp;

                return timestamp != null ? context.formatDate(timestamp) : null;
              },
            ),
          );

          final items = [
            transferInitiated,
            transferSent,
            withdrawSuccess,
          ];

          final List<Widget> actions = payment.status.maybeMap(
            success: (s) => [
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.ok,
                onPressed: () => context.router.pop(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CpTextButton(
                  variant: CpTextButtonVariant.light,
                  text: context.l10n.moreDetails,
                  onPressed: () {
                    final link = s.txId
                        .let(createTransactionLink)
                        .let(Uri.parse)
                        .toString();
                    context.openLink(link);
                  },
                ),
              ),
            ],
            withdrawn: (s) => [
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CpTextButton(
                  variant: CpTextButtonVariant.light,
                  text: context.l10n.moreDetails,
                  onPressed: () {
                    final link = s.txId
                        .let(createTransactionLink)
                        .let(Uri.parse)
                        .toString();
                    context.openLink(link);
                  },
                ),
              ),
            ],
            orElse: () => const [],
          );

          final String? statusTitle = payment.status.mapOrNull(
            success: always(context.l10n.withdrawalSentTitle),
            withdrawn: always(context.l10n.transferSuccessTitle),
          );

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
            success: always(context.l10n.withdrawalSuccessMessage),
            withdrawn: always(context.l10n.withdrawalReceivedMessage),
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
            success: always(1),
            withdrawn: always(2),
          );

          final animated = timelineStatus == CpTimelineStatus.inProgress &&
              payment.status.maybeMap(orElse: T, success: F);

          return StatusScreen(
            onBackButtonPressed: () => context.router.pop(),
            title: context.l10n.withdrawalTitle,
            statusType: statusType,
            statusTitle: statusTitle?.let(Text.new),
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
                  ...actions,
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        },
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/utils.dart';
import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/timeline.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../l10n/device_locale.dart';
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
          final locale = DeviceLocale.localeOf(context);

          if (payment == null) {
            return TransferProgress(
              onBack: () => context.router.pop(),
            );
          }

          final transferInitiated = CpTimelineItem(
            title: context.l10n.withdrawalInitiated,
            subtitle: context.formatDate(payment.created),
            trailing: payment.amount.format(locale),
          );
          final transferSent = CpTimelineItem(
            title: context.l10n.withdrawalSent,
          );
          final withdrawSuccess = CpTimelineItem(
            title: context.l10n.withdrawalReceived,
            subtitle: switch (payment.status) {
              ORPStatusSuccess() => context.l10n.withdrawalTimelineNotice,
              ORPStatusWithdrawn(:final timestamp) =>
                context.formatDate(timestamp),
              _ => null,
            },
          );

          final items = [
            transferInitiated,
            transferSent,
            withdrawSuccess,
          ];

          final List<Widget> actions = switch (payment.status) {
            ORPStatusSuccess(:final tx) => [
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
                      final link = tx.id
                          .let(createTransactionLink)
                          .let(Uri.parse)
                          .toString();
                      context.openLink(link);
                    },
                  ),
                ),
              ],
            ORPStatusWithdrawn(:final tx) => [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: CpTextButton(
                    variant: CpTextButtonVariant.light,
                    text: context.l10n.moreDetails,
                    onPressed: () {
                      final link = tx.id
                          .let(createTransactionLink)
                          .let(Uri.parse)
                          .toString();
                      context.openLink(link);
                    },
                  ),
                ),
              ],
            _ => const [],
          };

          final String? statusTitle = switch (payment.status) {
            ORPStatusSuccess() => context.l10n.withdrawalSentTitle,
            ORPStatusWithdrawn() => context.l10n.transferSuccessTitle,
            _ => null,
          };

          final CpStatusType statusType = switch (payment.status) {
            ORPStatusTxCreated() ||
            ORPStatusTxSent() ||
            ORPStatusSuccess() =>
              CpStatusType.info,
            ORPStatusWithdrawn() => CpStatusType.success,
            ORPStatusTxFailure() => CpStatusType.error,
          };

          final String statusContent = switch (payment.status) {
            ORPStatusTxCreated() ||
            ORPStatusTxSent() =>
              context.l10n.splitKeyTransactionLoading,
            ORPStatusSuccess() => context.l10n.withdrawalSuccessMessage,
            ORPStatusWithdrawn() => context.l10n.withdrawalReceivedMessage,
            ORPStatusTxFailure(:final reason) => [
                context.l10n.splitKeyErrorMessage2,
                if (reason == TxFailureReason.insufficientFunds)
                  context.l10n.errorMessageInsufficientFunds
                else
                  context.l10n.splitKeyErrorRetry,
              ].join(' '),
          };

          final CpTimelineStatus timelineStatus = switch (payment.status) {
            ORPStatusWithdrawn() => CpTimelineStatus.success,
            ORPStatusTxFailure() => CpTimelineStatus.failure,
            _ => CpTimelineStatus.inProgress,
          };

          final int activeItem = switch (payment.status) {
            ORPStatusTxFailure() || ORPStatusTxCreated() => 0,
            ORPStatusTxSent() || ORPStatusSuccess() => 1,
            ORPStatusWithdrawn() => 2,
          };

          final animated = timelineStatus == CpTimelineStatus.inProgress &&
              payment.status is! ORPStatusSuccess;

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

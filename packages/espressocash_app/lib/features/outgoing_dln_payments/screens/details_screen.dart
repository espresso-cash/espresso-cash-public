import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../core/presentation/utils.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../../../ui/timeline.dart';
import '../../transactions/services/create_transaction_link.dart';
import '../../transactions/widgets/transfer_progress.dart';
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
          final locale = DeviceLocale.localeOf(context);

          if (order == null) {
            return TransferProgress(onBack: () => context.router.pop());
          }

          final CpStatusType statusType = order.status.map(
            txFailure: always(CpStatusType.error),
            txCreated: always(CpStatusType.info),
            txSent: always(CpStatusType.info),
            success: always(CpStatusType.info),
            fulfilled: always(CpStatusType.success),
          );

          final String? statusTitle = order.status.mapOrNull(
            fulfilled: always(context.l10n.transferSuccessTitle),
          );

          final amount = order.amount.format(locale);

          final String statusContent = order.status.maybeMap(
            fulfilled: always('Your order has been fulfilled'),
            success: always('Your order is awaiting fulfillment'),
            txFailure: (it) => [
              context.l10n.splitKeyErrorMessage2,
              'Please try again later.',
            ].join(' '),
            orElse: always('Sending $amount'),
          );

          final CpTimelineStatus timelineStatus = order.status.mapOrNull(
                fulfilled: always(CpTimelineStatus.success),
                txFailure: always(CpTimelineStatus.failure),
              ) ??
              CpTimelineStatus.inProgress;

          final paymentInitiated = CpTimelineItem(
            title: context.l10n.paymentInitiated,
            trailing: order.amount.format(locale),
            subtitle: order.created.let((t) => context.formatDate(t)),
          );
          const txCreated = CpTimelineItem(
            title: 'Transaction has been sent',
          );
          const paymentSuccess = CpTimelineItem(
            title: 'Money has been received',
          );

          final int activeItem = order.status.map(
            txFailure: always(0),
            txCreated: always(1),
            txSent: always(1),
            success: always(2),
            fulfilled: always(2),
          );

          final normalItems = [
            paymentInitiated,
            txCreated,
            paymentSuccess,
          ];

          final items = order.status.mapOrNull(
                fulfilled: always(normalItems),
                success: always(normalItems),
              ) ??
              normalItems;

          final List<Widget> actions = switch (order.status) {
            OutgoingDlnPaymentStatusSuccess(:final tx) ||
            OutgoingDlnPaymentStatusFulfilled(:final tx) =>
              [
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
            _ => [],
          };

          final animated = timelineStatus == CpTimelineStatus.inProgress;

          return StatusScreen(
            onBackButtonPressed: () => context.router.pop(),
            title: context.l10n.splitKeyTransferTitle,
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
                ],
              ),
            ),
          );
        },
      );
}

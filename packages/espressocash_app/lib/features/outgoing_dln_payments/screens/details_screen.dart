import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../core/presentation/utils.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/partner_order_id.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../../../ui/timeline.dart';
import '../../intercom/services/intercom_service.dart';
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

          return order == null
              ? TransferProgress(onBack: () => context.router.pop())
              : OutgoingDlnOrderScreenContent(order: order);
        },
      );
}

class OutgoingDlnOrderScreenContent extends StatelessWidget {
  const OutgoingDlnOrderScreenContent({
    super.key,
    required this.order,
  });

  final OutgoingDlnPayment order;

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;

    final String? statusTitle = order.status.mapOrNull(
      fulfilled: always(context.l10n.transferSuccessTitle),
    );

    final amount = order.amount.format(locale, maxDecimals: 2);

    final String statusContent = order.status.maybeMap(
      fulfilled: always(context.l10n.transactionFulfilled),
      success: always(context.l10n.transactionAwaitingFulfillment),
      txFailure: (it) => [
        context.l10n.splitKeyErrorMessage2,
        context.l10n.tryAgainLater,
      ].join(' '),
      unfulfilled: always(context.l10n.outgoingDlnFailure),
      orElse: always(context.l10n.paymentProgressOngoing(amount)),
    );

    final Widget? primaryButton = order.status.mapOrNull(
      unfulfilled: always(const _ContactUsButton()),
    );

    final Widget? secondaryButton = order.status.mapOrNull(
      success: (e) => _MoreDetailsButton(signature: e.tx.id),
      fulfilled: (e) => _MoreDetailsButton(signature: e.tx.id),
      unfulfilled: (e) => _MoreDetailsButton(signature: e.tx.id),
    );

    final partnerOrderId = order.status.mapOrNull(
      success: (tx) => tx.orderId,
      fulfilled: (tx) => tx.orderId,
      unfulfilled: (tx) => tx.orderId,
    );

    return StatusScreen(
      onBackButtonPressed: () => context.router.pop(),
      title: context.l10n.splitKeyTransferTitle,
      statusType: order.status.toStatusType(),
      statusTitle: statusTitle?.let(Text.new),
      statusContent: Text(statusContent),
      content: CpContentPadding(
        child: Column(
          children: [
            const Spacer(flex: 1),
            _Timeline(
              status: order.status,
              amount: order.amount,
              created: order.created,
            ),
            const Spacer(flex: 4),
            if (partnerOrderId != null && partnerOrderId.isNotEmpty)
              PartnerOrderIdWidget(orderId: partnerOrderId),
            if (primaryButton != null) ...[
              const SizedBox(height: 12),
              primaryButton,
            ],
            if (secondaryButton != null) ...[
              const SizedBox(height: 16),
              secondaryButton,
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.status,
    required this.amount,
    required this.created,
  });

  final OutgoingDlnPaymentStatus status;
  final CryptoAmount amount;
  final DateTime created;

  @override
  Widget build(BuildContext context) {
    final CpTimelineStatus timelineStatus = status.toTimelineStatus();
    final animated = timelineStatus == CpTimelineStatus.inProgress;
    final int activeItem = status.toActiveItem();

    final paymentInitiated = CpTimelineItem(
      title: context.l10n.paymentInitiated,
      trailing: amount.format(context.locale, maxDecimals: 2),
      subtitle: created.let((t) => context.formatDate(t)),
    );
    final txCreated = CpTimelineItem(
      title: context.l10n.transactionSentTimeline,
    );
    final paymentSuccess = CpTimelineItem(
      title: context.l10n.moneyReceived,
    );

    final items = [
      paymentInitiated,
      txCreated,
      paymentSuccess,
    ];

    return CpTimeline(
      status: timelineStatus,
      items: items,
      active: activeItem,
      animated: animated,
    );
  }
}

class _MoreDetailsButton extends StatelessWidget {
  const _MoreDetailsButton({required this.signature});

  final String signature;

  @override
  Widget build(BuildContext context) => CpTextButton(
        variant: CpTextButtonVariant.light,
        text: context.l10n.moreDetails,
        onPressed: () {
          final link =
              createTransactionLink(signature).let(Uri.parse).toString();
          context.openLink(link);
        },
      );
}

class _ContactUsButton extends StatelessWidget {
  const _ContactUsButton();

  @override
  Widget build(BuildContext context) => CpButton(
        size: CpButtonSize.big,
        width: double.infinity,
        text: context.l10n.contactUs,
        onPressed: () => sl<IntercomService>().displayMessenger(),
      );
}

extension on OutgoingDlnPaymentStatus {
  CpStatusType toStatusType() => this.map(
        txFailure: always(CpStatusType.error),
        txCreated: always(CpStatusType.info),
        txSent: always(CpStatusType.info),
        success: always(CpStatusType.info),
        fulfilled: always(CpStatusType.success),
        unfulfilled: always(CpStatusType.error),
      );

  CpTimelineStatus toTimelineStatus() => this.map(
        txFailure: always(CpTimelineStatus.failure),
        txCreated: always(CpTimelineStatus.inProgress),
        txSent: always(CpTimelineStatus.inProgress),
        success: always(CpTimelineStatus.inProgress),
        fulfilled: always(CpTimelineStatus.success),
        unfulfilled: always(CpTimelineStatus.failure),
      );

  int toActiveItem() => this.map(
        txFailure: always(0),
        txCreated: always(1),
        txSent: always(1),
        success: always(2),
        fulfilled: always(2),
        unfulfilled: always(2),
      );
}

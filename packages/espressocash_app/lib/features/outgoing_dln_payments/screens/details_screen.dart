import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:recase/recase.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/partner_order_id.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../../../ui/timeline.dart';
import '../../../ui/web_view_screen.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../intercom/services/intercom_service.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../data/repository.dart';
import '../models/outgoing_payment.dart';
import '../services/dln_order_service.dart';

class OutgoingDlnPaymentDetailsScreen extends StatefulWidget {
  const OutgoingDlnPaymentDetailsScreen({
    super.key,
    required this.id,
  });

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => OutgoingDlnPaymentDetailsScreen(id: id),
        ),
      );

  static void open(BuildContext context, {required String id}) =>
      Navigator.of(context).pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (context) => OutgoingDlnPaymentDetailsScreen(id: id),
        ),
        (route) => route.isFirst,
      );

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
              ? TransferProgress(onBack: () => Navigator.pop(context))
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

    final receiverBlockchain = order.payment.receiverBlockchain.name.titleCase;

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

    void handleCanceled() => showConfirmationDialog(
          context,
          title: context.l10n.outgoingSplitKeyPayments_btnCancel.toUpperCase(),
          message: context
              .l10n.outgoingSplitKeyPayments_lblCancelConfirmationSubtitle,
          onConfirm: () {
            Navigator.pop(context);
            sl<OutgoingDlnPaymentService>().cancel(order.id);
          },
        );

    final Widget? secondaryButton = order.status.mapOrNull(
      success: (e) => e.orderId?.let((p) => _MoreDetailsButton(orderId: p)),
      fulfilled: (e) => _MoreDetailsButton(orderId: e.orderId),
      unfulfilled: (e) => _MoreDetailsButton(orderId: e.orderId),
      txFailure: (_) => _CancelButton(onPressed: handleCanceled),
    );

    final partnerOrderId = order.status.mapOrNull(
      success: (tx) => tx.orderId,
      fulfilled: (tx) => tx.orderId,
      unfulfilled: (tx) => tx.orderId,
    );

    return StatusScreen(
      onBackButtonPressed: () => Navigator.pop(context),
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
              receiverBlockchain: receiverBlockchain,
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
    required this.receiverBlockchain,
  });

  final OutgoingDlnPaymentStatus status;
  final CryptoAmount amount;
  final DateTime created;
  final String receiverBlockchain;

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
      title: '${context.l10n.moneyReceived} on $receiverBlockchain',
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
  const _MoreDetailsButton({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) => CpTextButton(
        variant: CpTextButtonVariant.light,
        text: context.l10n.moreDetails,
        onPressed: () {
          final link = 'https://app.debridge.finance/order?orderId=$orderId';

          context.openLink(link);
        },
      );
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => CpTextButton(
        variant: CpTextButtonVariant.light,
        text: context.l10n.outgoingSplitKeyPayments_btnCancel,
        onPressed: onPressed,
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

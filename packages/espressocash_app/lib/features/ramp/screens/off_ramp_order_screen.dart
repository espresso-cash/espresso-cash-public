import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../data/db/db.dart';
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
import '../../../ui/theme.dart';
import '../../../ui/timeline.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../intercom/services/intercom_service.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../services/off_ramp_order_service.dart';
import '../widgets/off_ramp_confirmation.dart';

class OffRampOrderScreen extends StatefulWidget {
  const OffRampOrderScreen({super.key, required this.orderId});

  static void push(BuildContext context, {required String id}) => Navigator.of(
    context,
  ).push<void>(MaterialPageRoute(builder: (context) => OffRampOrderScreen(orderId: id)));

  static void pushReplacement(BuildContext context, {required String id}) => Navigator.of(
    context,
  ).pushReplacement(MaterialPageRoute<void>(builder: (context) => OffRampOrderScreen(orderId: id)));

  final String orderId;

  @override
  State<OffRampOrderScreen> createState() => _OffRampOrderScreenState();
}

class _OffRampOrderScreenState extends State<OffRampOrderScreen> {
  late final Stream<OffRampOrder> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<OffRampOrderService>().watch(widget.orderId);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
    stream: _stream,
    builder: (context, snapshot) {
      final order = snapshot.data;

      return order == null
          ? TransferProgress(onBack: () => Navigator.pop(context))
          : OffRampOrderScreenContent(order: order);
    },
  );
}

class OffRampOrderScreenContent extends StatelessWidget {
  const OffRampOrderScreenContent({super.key, required this.order});

  final OffRampOrder order;

  @override
  Widget build(BuildContext context) {
    if (order.status == OffRampOrderStatus.depositTxRequired) {
      return OffRampConfirmation(order: order);
    }

    final locale = DeviceLocale.localeOf(context);

    void handleCanceled() => showConfirmationDialog(
      context,
      title: context.l10n.offRampCancelTitle.toUpperCase(),
      message: context.l10n.offRampCancelSubtitle,
      onConfirm: () {
        sl<OffRampOrderService>().cancel(order.id);
      },
    );

    void handleRetry() => sl<OffRampOrderService>().retry(order.id);

    final String? statusTitle = order.status == OffRampOrderStatus.completed
        ? context.l10n.transferSuccessTitle
        : null;

    final totalAmount = order.fee?.let((fee) => order.amount + fee) ?? order.amount;

    final receiveAmount = order.receiveAmount;

    final String statusContent = switch (order.status) {
      OffRampOrderStatus.depositTxRequired ||
      OffRampOrderStatus.creatingDepositTx ||
      OffRampOrderStatus.depositTxReady ||
      OffRampOrderStatus.sendingDepositTx => context.l10n.offRampWithdrawOngoing(
        totalAmount.format(locale),
      ),
      OffRampOrderStatus.waitingForPartner => context.l10n.offRampWaitingForPartner,
      OffRampOrderStatus.depositTxConfirmError ||
      OffRampOrderStatus.depositError => context.l10n.offRampDepositError,
      OffRampOrderStatus.failure ||
      OffRampOrderStatus.rejected => context.l10n.offRampWithdrawalFailure,
      OffRampOrderStatus.completed => context.l10n.offRampWithdrawSuccess,
      OffRampOrderStatus.cancelled => context.l10n.offRampWithdrawCancelled(
        totalAmount.format(locale),
      ),
      OffRampOrderStatus.insufficientFunds =>
        '${context.l10n.splitKeyErrorMessage2} ${context.l10n.errorMessageInsufficientFunds}',
      OffRampOrderStatus.preProcessing ||
      OffRampOrderStatus.postProcessing ||
      OffRampOrderStatus.ready => context.l10n.preparingWithdrawal,
      OffRampOrderStatus.processingRefund => context.l10n.processingRefund,
      OffRampOrderStatus.waitingForRefundBridge => context.l10n.refundInProgressText,
      OffRampOrderStatus.refunded => context.l10n.refundSuccessText,
      OffRampOrderStatus.waitingPartnerReview => 'Waiting for partner review',
    };

    final Widget? primaryButton = switch (order.status) {
      OffRampOrderStatus.depositError ||
      OffRampOrderStatus.depositTxConfirmError ||
      OffRampOrderStatus.insufficientFunds => _RetryButton(handleRetry: handleRetry),
      OffRampOrderStatus.failure || OffRampOrderStatus.rejected => const _ContactUsButton(),
      OffRampOrderStatus.preProcessing ||
      OffRampOrderStatus.postProcessing ||
      OffRampOrderStatus.ready ||
      OffRampOrderStatus.depositTxRequired ||
      OffRampOrderStatus.creatingDepositTx ||
      OffRampOrderStatus.depositTxReady ||
      OffRampOrderStatus.sendingDepositTx ||
      OffRampOrderStatus.processingRefund ||
      OffRampOrderStatus.waitingForRefundBridge ||
      OffRampOrderStatus.completed ||
      OffRampOrderStatus.refunded ||
      OffRampOrderStatus.cancelled ||
      OffRampOrderStatus.waitingForPartner ||
      OffRampOrderStatus.waitingPartnerReview => null,
    };

    const theme = CpThemeData.black();

    final showCancelButton = order.status.isCancellable;

    final bridgeTimeInMinutes = order.status == OffRampOrderStatus.waitingForRefundBridge ? 3 : 10;

    final bridgeSubtitleContent = [
      const SizedBox(height: 6),
      Text(
        context.l10n.transferInProgressText(bridgeTimeInMinutes),
        style: const TextStyle(fontSize: 14),
      ),
    ];

    return StatusScreen(
      theme: theme,
      title: context.l10n.offRampWithdrawTitle.toUpperCase(),
      statusType: order.status.toStatusType(),
      statusTitle: statusTitle?.let(Text.new),
      statusContent: Column(
        children: [
          Text(statusContent),
          if (order.status.isWaitingForBridge) ...bridgeSubtitleContent,
        ],
      ),
      content: CpContentPadding(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _Timeline(order: order, amount: totalAmount, receiveAmount: receiveAmount),
              PartnerOrderIdWidget(orderId: order.partnerOrderId),
              if (primaryButton != null) ...[const SizedBox(height: 12), primaryButton],
              Visibility(
                visible: showCancelButton,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: _CancelButton(handleCanceled: handleCanceled),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.handleRetry});

  final VoidCallback handleRetry;

  @override
  Widget build(BuildContext context) => CpButton(
    size: CpButtonSize.big,
    width: double.infinity,
    text: context.l10n.retry,
    onPressed: handleRetry,
  );
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.handleCanceled});

  final VoidCallback handleCanceled;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: CpTextButton(
      text: context.l10n.offRampCancelTitle,
      variant: CpTextButtonVariant.light,
      onPressed: handleCanceled,
    ),
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

class _Timeline extends StatelessWidget {
  const _Timeline({required this.order, required this.amount, this.receiveAmount});

  final OffRampOrder order;
  final Amount amount;
  final Amount? receiveAmount;

  @override
  Widget build(BuildContext context) {
    final CpTimelineStatus timelineStatus = order.status.toTimelineStatus();
    final animated = timelineStatus == CpTimelineStatus.inProgress;
    final int activeItem = order.status.toActiveItem();

    final withdrawInitiated = CpTimelineItem(
      title: context.l10n.offRampWithdrawInitiated,
      trailing: amount.format(context.locale),
      subtitle: order.created.let((t) => context.formatDate(t)),
    );

    final amountSent = CpTimelineItem(title: context.l10n.offRampWithdrawSent);

    final paymentSuccess = CpTimelineItem(
      title: context.l10n.offRampWithdrawReceived,
      trailing: receiveAmount?.format(context.locale),
      subtitle: order.resolved?.let((t) => context.formatDate(t)),
    );

    final paymentCanceled = CpTimelineItem(
      title: context.l10n.offRampWithdrawCancelledTitle,
      subtitle: order.resolved?.let((t) => context.formatDate(t)),
    );

    final refunding = CpTimelineItem(
      title: 'Refunding USDC',
      trailing: order.bridgeAmount?.let(
        (e) => e.isZero ? null : e.format(context.locale, maxDecimals: 2),
      ),
    );

    final normalItems = [withdrawInitiated, amountSent, paymentSuccess];
    final cancelingItems = [withdrawInitiated, paymentCanceled];
    final refundingItems = [withdrawInitiated, refunding, paymentCanceled];

    final items = order.status == OffRampOrderStatus.cancelled
        ? cancelingItems
        : order.status.isRefunding
        ? refundingItems
        : normalItems;

    return CpTimeline(status: timelineStatus, items: items, active: activeItem, animated: animated);
  }
}

extension on OffRampOrderStatus {
  CpStatusType toStatusType() => switch (this) {
    OffRampOrderStatus.preProcessing ||
    OffRampOrderStatus.postProcessing ||
    OffRampOrderStatus.ready ||
    OffRampOrderStatus.depositTxRequired ||
    OffRampOrderStatus.creatingDepositTx ||
    OffRampOrderStatus.depositTxReady ||
    OffRampOrderStatus.sendingDepositTx ||
    OffRampOrderStatus.processingRefund ||
    OffRampOrderStatus.waitingForRefundBridge ||
    OffRampOrderStatus.waitingPartnerReview ||
    OffRampOrderStatus.waitingForPartner => CpStatusType.info,
    OffRampOrderStatus.depositError ||
    OffRampOrderStatus.depositTxConfirmError ||
    OffRampOrderStatus.insufficientFunds ||
    OffRampOrderStatus.rejected ||
    OffRampOrderStatus.failure => CpStatusType.error,
    OffRampOrderStatus.completed => CpStatusType.success,
    OffRampOrderStatus.cancelled || OffRampOrderStatus.refunded => CpStatusType.neutral,
  };

  CpTimelineStatus toTimelineStatus() => switch (this) {
    OffRampOrderStatus.depositTxRequired ||
    OffRampOrderStatus.creatingDepositTx ||
    OffRampOrderStatus.depositTxReady ||
    OffRampOrderStatus.sendingDepositTx ||
    OffRampOrderStatus.preProcessing ||
    OffRampOrderStatus.postProcessing ||
    OffRampOrderStatus.ready ||
    OffRampOrderStatus.processingRefund ||
    OffRampOrderStatus.waitingForRefundBridge ||
    OffRampOrderStatus.waitingPartnerReview ||
    OffRampOrderStatus.waitingForPartner => CpTimelineStatus.inProgress,
    OffRampOrderStatus.depositTxConfirmError ||
    OffRampOrderStatus.depositError ||
    OffRampOrderStatus.insufficientFunds ||
    OffRampOrderStatus.rejected ||
    OffRampOrderStatus.failure => CpTimelineStatus.failure,
    OffRampOrderStatus.completed => CpTimelineStatus.success,
    OffRampOrderStatus.cancelled || OffRampOrderStatus.refunded => CpTimelineStatus.neutral,
  };

  int toActiveItem() => switch (this) {
    OffRampOrderStatus.waitingPartnerReview ||
    OffRampOrderStatus.preProcessing ||
    OffRampOrderStatus.postProcessing ||
    OffRampOrderStatus.ready ||
    OffRampOrderStatus.depositTxRequired ||
    OffRampOrderStatus.creatingDepositTx ||
    OffRampOrderStatus.depositTxReady ||
    OffRampOrderStatus.sendingDepositTx ||
    OffRampOrderStatus.depositError ||
    OffRampOrderStatus.depositTxConfirmError ||
    OffRampOrderStatus.insufficientFunds ||
    OffRampOrderStatus.processingRefund ||
    OffRampOrderStatus.waitingForRefundBridge ||
    OffRampOrderStatus.rejected ||
    OffRampOrderStatus.cancelled => 1,
    OffRampOrderStatus.waitingForPartner ||
    OffRampOrderStatus.failure ||
    OffRampOrderStatus.completed ||
    OffRampOrderStatus.refunded => 2,
  };

  bool get isRefunding =>
      this == OffRampOrderStatus.refunded ||
      this == OffRampOrderStatus.processingRefund ||
      this == OffRampOrderStatus.waitingForRefundBridge;

  bool get isWaitingForBridge =>
      this == OffRampOrderStatus.preProcessing ||
      this == OffRampOrderStatus.waitingForRefundBridge ||
      this == OffRampOrderStatus.postProcessing;
}

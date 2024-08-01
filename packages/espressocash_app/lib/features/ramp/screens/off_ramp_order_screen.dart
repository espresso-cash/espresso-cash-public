import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/gestures.dart';
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
import '../../../ui/web_view_screen.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../intercom/services/intercom_service.dart';
import '../../ramp_partner/models/ramp_partner.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../partners/moneygram/widgets/extensions.dart';
import '../partners/moneygram/widgets/style.dart';
import '../services/off_ramp_order_service.dart';
import '../widgets/off_ramp_confirmation.dart';

class OffRampOrderScreen extends StatefulWidget {
  const OffRampOrderScreen({super.key, required this.orderId});

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => OffRampOrderScreen(orderId: id),
        ),
      );

  static void pushReplacement(BuildContext context, {required String id}) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => OffRampOrderScreen(orderId: id),
        ),
      );

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
  const OffRampOrderScreenContent({
    super.key,
    required this.order,
  });

  final OffRampOrder order;

  @override
  Widget build(BuildContext context) {
    if (order.status == OffRampOrderStatus.depositTxRequired) {
      return OffRampConfirmation(order: order);
    }

    final isMoneygramOrder = order.partner == RampPartner.moneygram;

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

    Future<void> handleContinue() async {
      await context.openMoneygramWithdrawUrl(order);
    }

    Future<void> handleMoreInfo() async {
      await context.openMoneygramMoreInfoUrl(order);
    }

    final String? statusTitle = order.status == OffRampOrderStatus.completed
        ? context.l10n.transferSuccessTitle
        : null;

    final totalAmount =
        order.fee?.let((fee) => order.amount + fee) ?? order.amount;

    final receiveAmount = order.receiveAmount;

    final String statusContent = switch (order.status) {
      OffRampOrderStatus.depositTxRequired ||
      OffRampOrderStatus.creatingDepositTx ||
      OffRampOrderStatus.depositTxReady ||
      OffRampOrderStatus.sendingDepositTx =>
        context.l10n.offRampWithdrawOngoing(
          totalAmount.format(locale),
        ),
      OffRampOrderStatus.waitingForPartner =>
        context.l10n.offRampWaitingForPartner,
      OffRampOrderStatus.depositTxConfirmError ||
      OffRampOrderStatus.depositError =>
        context.l10n.offRampDepositError,
      OffRampOrderStatus.failure => context.l10n.offRampWithdrawalFailure,
      OffRampOrderStatus.completed => context.l10n.offRampWithdrawSuccess,
      OffRampOrderStatus.cancelled => context.l10n.offRampWithdrawCancelled(
          totalAmount.format(locale),
        ),
      OffRampOrderStatus.insufficientFunds =>
        '${context.l10n.splitKeyErrorMessage2} ${context.l10n.errorMessageInsufficientFunds}',
      OffRampOrderStatus.preProcessing ||
      OffRampOrderStatus.postProcessing =>
        context.l10n.preparingWithdrawal,
      OffRampOrderStatus.ready => context.l10n.openMoneygramIframeText,
      OffRampOrderStatus.processingRefund => context.l10n.processingRefund,
      OffRampOrderStatus.waitingForRefundBridge =>
        context.l10n.refundInProgressText,
      OffRampOrderStatus.refunded => context.l10n.refundSuccessText,
    };

    final Widget? primaryButton = switch (order.status) {
      OffRampOrderStatus.depositError ||
      OffRampOrderStatus.depositTxConfirmError ||
      OffRampOrderStatus.insufficientFunds =>
        order.partner != RampPartner.moneygram
            ? _RetryButton(handleRetry: handleRetry)
            : null,
      OffRampOrderStatus.failure => const _ContactUsButton(),
      OffRampOrderStatus.ready =>
        _ContinueButton(handleContinue: handleContinue),
      OffRampOrderStatus.waitingForPartner => isMoneygramOrder
          ? _MoreInfoButton(handleMoreInfo: handleMoreInfo)
          : null,
      OffRampOrderStatus.preProcessing ||
      OffRampOrderStatus.postProcessing ||
      OffRampOrderStatus.depositTxRequired ||
      OffRampOrderStatus.creatingDepositTx ||
      OffRampOrderStatus.depositTxReady ||
      OffRampOrderStatus.sendingDepositTx ||
      OffRampOrderStatus.processingRefund ||
      OffRampOrderStatus.waitingForRefundBridge ||
      OffRampOrderStatus.completed ||
      OffRampOrderStatus.refunded ||
      OffRampOrderStatus.cancelled =>
        null,
    };

    final theme = isMoneygramOrder
        ? const CpThemeData.light()
        : const CpThemeData.black();

    final showMoneygramCancel = order.partner == RampPartner.moneygram &&
        order.status == OffRampOrderStatus.insufficientFunds;

    final showCancelButton = order.status == OffRampOrderStatus.depositError ||
        order.status == OffRampOrderStatus.ready ||
        showMoneygramCancel;

    final bridgeSubtitleContent = [
      const SizedBox(height: 6),
      Text(
        context.l10n.transferInProgressText,
        style: const TextStyle(fontSize: 14),
      ),
    ];

    return CpTheme(
      theme: theme,
      child: StatusScreen(
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
                _Timeline(
                  order: order,
                  amount: totalAmount,
                  receiveAmount: receiveAmount,
                ),
                if (isMoneygramOrder) _MgAdditionalInfo(order: order),
                PartnerOrderIdWidget(orderId: order.partnerOrderId),
                if (primaryButton != null) ...[
                  const SizedBox(height: 12),
                  primaryButton,
                ],
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

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.handleContinue});

  final VoidCallback handleContinue;

  @override
  Widget build(BuildContext context) => CpButton(
        size: CpButtonSize.big,
        width: double.infinity,
        text: context.l10n.continueToMoneygram,
        onPressed: handleContinue,
      );
}

class _MoreInfoButton extends StatelessWidget {
  const _MoreInfoButton({required this.handleMoreInfo});

  final VoidCallback handleMoreInfo;

  @override
  Widget build(BuildContext context) => CpButton(
        size: CpButtonSize.big,
        width: double.infinity,
        text: context.l10n.moreInfo,
        onPressed: handleMoreInfo,
      );
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.handleCanceled});

  final VoidCallback handleCanceled;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 12),
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

class _MgAdditionalInfo extends StatelessWidget {
  const _MgAdditionalInfo({
    required this.order,
  });
  final OffRampOrder order;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (order.fee case final fee?)
            Text(
              'MoneyGram Fee: ${fee.format(context.locale, maxDecimals: 2)}',
              style: _additionalInfoTextStyle,
            ),
          Text(
            'Status: ${order.status.toMoneygramStatus(context).toUpperCase()}',
            style: _additionalInfoTextStyle,
          ),
          if (order.moreInfoUrl case final moreInfoUrl?)
            Text.rich(
              TextSpan(
                style: _additionalInfoTextStyle,
                children: <TextSpan>[
                  const TextSpan(
                    text: 'Additional info: ',
                  ),
                  TextSpan(
                    text: 'Click here',
                    style: const TextStyle(
                      color: Color(0xffCB6E00),
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        WebViewScreen.push(
                          context,
                          url: Uri.parse(moreInfoUrl),
                          title:
                              context.l10n.offRampWithdrawTitle.toUpperCase(),
                          theme: const CpThemeData.light(),
                          onLoaded: (controller) async {
                            await controller.evaluateJavascript(
                              source: await loadMoneygramStyle(),
                            );
                          },
                        );
                      },
                  ),
                ],
              ),
            ),
          if (order.referenceNumber case final referenceNumber?)
            Text(
              'Reference number: $referenceNumber',
              style: _additionalInfoTextStyle,
            ),
        ],
      );
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.order,
    required this.amount,
    this.receiveAmount,
  });

  final OffRampOrder order;
  final Amount amount;
  final Amount? receiveAmount;

  @override
  Widget build(BuildContext context) {
    final isMoneygramOrder = order.partner == RampPartner.moneygram;
    final CpTimelineStatus timelineStatus = order.status.toTimelineStatus();
    final animated = timelineStatus == CpTimelineStatus.inProgress &&
        order.status != OffRampOrderStatus.ready;

    final int activeItem = isMoneygramOrder
        ? order.status.toActiveItemForMoneygram()
        : order.status.toActiveItem();

    final withdrawInitiated = CpTimelineItem(
      title: context.l10n.offRampWithdrawInitiated,
      trailing: amount.format(context.locale),
      subtitle: order.created.let((t) => context.formatDate(t)),
    );

    final bridgingToStellar = CpTimelineItem(
      title: context.l10n.bridgingText,
      trailing: order.bridgeAmount?.let(
        (e) => e.isZero ? null : e.format(context.locale, maxDecimals: 2),
      ),
    );
    final amountSent = CpTimelineItem(
      title: context.l10n.offRampWithdrawSent,
    );
    final paymentSuccess = CpTimelineItem(
      title: context.l10n.offRampWithdrawReceived,
      trailing: receiveAmount?.format(context.locale),
      subtitle: order.resolved?.let((t) => context.formatDate(t)),
    );
    final paymentCanceled = CpTimelineItem(
      title: context.l10n.offRampWithdrawCancelledTitle,
      subtitle: order.resolved?.let((t) => context.formatDate(t)),
    );
    const refunding = CpTimelineItem(
      title: 'Refunding USDC',
    );

    final normalItems = [
      withdrawInitiated,
      if (isMoneygramOrder) bridgingToStellar,
      amountSent,
      paymentSuccess,
    ];

    final cancelingItems = [
      withdrawInitiated,
      paymentCanceled,
    ];

    final refundingItems = [
      withdrawInitiated,
      refunding,
      paymentCanceled,
    ];

    final items = order.status == OffRampOrderStatus.cancelled
        ? cancelingItems
        : order.status.isRefunding
            ? refundingItems
            : normalItems;

    return CpTimeline(
      status: timelineStatus,
      items: items,
      active: activeItem,
      animated: animated,
    );
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
        OffRampOrderStatus.waitingForPartner =>
          CpStatusType.info,
        OffRampOrderStatus.depositError ||
        OffRampOrderStatus.depositTxConfirmError ||
        OffRampOrderStatus.insufficientFunds ||
        OffRampOrderStatus.failure =>
          CpStatusType.error,
        OffRampOrderStatus.completed => CpStatusType.success,
        OffRampOrderStatus.cancelled ||
        OffRampOrderStatus.refunded =>
          CpStatusType.neutral,
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
        OffRampOrderStatus.waitingForPartner =>
          CpTimelineStatus.inProgress,
        OffRampOrderStatus.depositTxConfirmError ||
        OffRampOrderStatus.depositError ||
        OffRampOrderStatus.insufficientFunds ||
        OffRampOrderStatus.failure =>
          CpTimelineStatus.failure,
        OffRampOrderStatus.completed => CpTimelineStatus.success,
        OffRampOrderStatus.cancelled ||
        OffRampOrderStatus.refunded =>
          CpTimelineStatus.neutral,
      };

  int toActiveItem() => switch (this) {
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
        OffRampOrderStatus.cancelled =>
          1,
        OffRampOrderStatus.waitingForPartner ||
        OffRampOrderStatus.failure ||
        OffRampOrderStatus.completed ||
        OffRampOrderStatus.refunded =>
          2,
      };

  int toActiveItemForMoneygram() => switch (this) {
        OffRampOrderStatus.preProcessing ||
        OffRampOrderStatus.postProcessing ||
        OffRampOrderStatus.depositError ||
        OffRampOrderStatus.depositTxConfirmError ||
        OffRampOrderStatus.insufficientFunds ||
        OffRampOrderStatus.processingRefund ||
        OffRampOrderStatus.ready ||
        OffRampOrderStatus.cancelled =>
          1,
        OffRampOrderStatus.depositTxRequired ||
        OffRampOrderStatus.creatingDepositTx ||
        OffRampOrderStatus.depositTxReady ||
        OffRampOrderStatus.waitingForRefundBridge ||
        OffRampOrderStatus.sendingDepositTx ||
        OffRampOrderStatus.refunded =>
          2,
        OffRampOrderStatus.waitingForPartner ||
        OffRampOrderStatus.failure ||
        OffRampOrderStatus.completed =>
          3,
      };

  bool get isRefunding =>
      this == OffRampOrderStatus.refunded ||
      this == OffRampOrderStatus.processingRefund ||
      this == OffRampOrderStatus.waitingForRefundBridge;

  bool get isWaitingForBridge =>
      this == OffRampOrderStatus.waitingForRefundBridge ||
      this == OffRampOrderStatus.postProcessing;

  String toMoneygramStatus(BuildContext context) => switch (this) {
        OffRampOrderStatus.preProcessing ||
        OffRampOrderStatus.postProcessing ||
        OffRampOrderStatus.depositTxRequired ||
        OffRampOrderStatus.creatingDepositTx ||
        OffRampOrderStatus.depositTxReady ||
        OffRampOrderStatus.sendingDepositTx ||
        OffRampOrderStatus.ready ||
        OffRampOrderStatus.processingRefund ||
        OffRampOrderStatus.waitingForRefundBridge ||
        OffRampOrderStatus.waitingForPartner =>
          context.l10n.pending,
        OffRampOrderStatus.depositError ||
        OffRampOrderStatus.depositTxConfirmError ||
        OffRampOrderStatus.insufficientFunds ||
        OffRampOrderStatus.failure =>
          context.l10n.failed,
        OffRampOrderStatus.completed => context.l10n.completed,
        OffRampOrderStatus.cancelled => context.l10n.cancelled,
        OffRampOrderStatus.refunded => context.l10n.refunded,
      };
}

const _additionalInfoTextStyle = TextStyle(
  color: Color(0xFF979593),
  fontSize: 14,
);

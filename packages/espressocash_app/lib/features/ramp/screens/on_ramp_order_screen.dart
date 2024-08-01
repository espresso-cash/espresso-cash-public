import 'package:dfunc/dfunc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../data/db/db.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/content_padding.dart';
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
import '../partners/moneygram/widgets/style.dart';
import '../services/on_ramp_order_service.dart';
import '../widgets/on_ramp_deposit_widget.dart';

class OnRampOrderScreen extends StatefulWidget {
  const OnRampOrderScreen({super.key, required this.orderId});

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => OnRampOrderScreen(orderId: id),
        ),
      );

  static void pushReplacement(BuildContext context, {required String id}) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (context) => OnRampOrderScreen(orderId: id),
        ),
      );

  final String orderId;

  @override
  State<OnRampOrderScreen> createState() => _OnRampOrderScreenState();
}

class _OnRampOrderScreenState extends State<OnRampOrderScreen> {
  late final Stream<OnRampOrder> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<OnRampOrderService>().watch(widget.orderId);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          final order = snapshot.data;

          return order == null
              ? TransferProgress(onBack: () => Navigator.pop(context))
              : OnRampOrderScreenContent(order: order);
        },
      );
}

class OnRampOrderScreenContent extends StatelessWidget {
  const OnRampOrderScreenContent({
    super.key,
    required this.order,
  });

  final OnRampOrder order;

  @override
  Widget build(BuildContext context) {
    final manualDeposit = order.manualDeposit;
    final bool isManualBankTransfer = manualDeposit != null;
    final isMoneygramOrder = order.partner == RampPartner.moneygram;

    final theme = isMoneygramOrder
        ? const CpThemeData.light()
        : const CpThemeData.black();

    if (order.status == OnRampOrderStatus.pending) {
      return CpTheme(
        theme: theme,
        child: TransferProgress(onBack: () => Navigator.pop(context)),
      );
    }

    if (order.status == OnRampOrderStatus.waitingForDeposit &&
        isManualBankTransfer) {
      return OnRampDepositWidget(
        partner: order.partner,
        deposit: (
          bankAccount: manualDeposit.bankAccount,
          bankName: manualDeposit.bankName,
          transferExpiryDate: manualDeposit.transferExpiryDate,
          transferAmount: manualDeposit.transferAmount,
          orderId: order.id,
          orderCreated: order.created,
          receiveAmount: order.receiveAmount,
          moreInfoUrl: order.additionalDetails.moreInfoUrl,
        ),
      );
    }

    final locale = DeviceLocale.localeOf(context);
    final amount = order.receiveAmount ?? order.submittedAmount;

    final String? statusTitle = order.status == OnRampOrderStatus.completed
        ? context.l10n.transferSuccessTitle
        : null;

    final String statusContent = switch (order.status) {
      OnRampOrderStatus.pending ||
      OnRampOrderStatus.preProcessing ||
      OnRampOrderStatus.waitingForBridge ||
      OnRampOrderStatus.waitingForDeposit ||
      OnRampOrderStatus.postProcessing ||
      OnRampOrderStatus.waitingForPartner =>
        context.l10n
            .onRampDepositOngoing(amount.format(locale, maxDecimals: 2)),
      OnRampOrderStatus.depositExpired => context.l10n.onRampDepositExpired,
      OnRampOrderStatus.failure => context.l10n.onRampDepositFailure,
      OnRampOrderStatus.completed => context.l10n.onRampDepositSuccess,
    };

    final String? statusSubtitle = switch (order.status) {
      OnRampOrderStatus.waitingForPartner ||
      OnRampOrderStatus.postProcessing =>
        context.l10n.onRampAwaitingFunds,
      OnRampOrderStatus.waitingForBridge =>
        'Transfer could take a few minutes...',
      OnRampOrderStatus.pending ||
      OnRampOrderStatus.preProcessing ||
      OnRampOrderStatus.waitingForDeposit ||
      OnRampOrderStatus.depositExpired ||
      OnRampOrderStatus.failure ||
      OnRampOrderStatus.completed =>
        null
    };

    final Widget? primaryButton = order.status == OnRampOrderStatus.failure
        ? const _ContactUsButton()
        : null;

    final depositAmount = isMoneygramOrder
        ? manualDeposit?.transferAmount
        : order.submittedAmount;

    return CpTheme(
      theme: theme,
      child: StatusScreen(
        title: context.l10n.depositTitle.toUpperCase(),
        statusType: order.status.toStatusType(),
        statusTitle: statusTitle?.let(Text.new),
        statusContent: Column(
          children: [
            Text(statusContent),
            if (statusSubtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                statusSubtitle,
                style: _contentSubtitleTextStyle,
              ),
            ],
          ],
        ),
        content: CpContentPadding(
          child: Column(
            children: [
              const Spacer(flex: 1),
              _Timeline(
                status: order.status,
                amount: depositAmount ?? order.submittedAmount,
                receiveAmount: order.receiveAmount,
                manualDeposit: manualDeposit,
                created: order.created,
                partner: order.partner,
              ),
              const Spacer(flex: 4),
              if (isMoneygramOrder)
                _MgAdditionalInfo(
                  details: order.additionalDetails,
                  status: order.status.toMoneygramStatus(),
                ),
              PartnerOrderIdWidget(orderId: order.partnerOrderId),
              if (primaryButton != null) ...[
                const SizedBox(height: 12),
                primaryButton,
              ],
              Visibility(
                visible: order.status == OnRampOrderStatus.depositExpired,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: _CancelButton(orderId: order.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: CpTextButton(
          text: context.l10n.offRampCancelTitle,
          variant: CpTextButtonVariant.light,
          onPressed: () {
            sl<OnRampOrderService>().delete(orderId);
            Navigator.pop(context);
          },
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
    required this.details,
    required this.status,
  });
  final AdditionalDetails details;
  final String status;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          if (details.fee case final fee?)
            Text(
              'MoneyGram Fee: ${fee.format(context.locale, maxDecimals: 2)}',
              style: _additionalInfoTextStyle,
            ),
          Text(
            'Status: ${status.toUpperCase()}',
            style: _additionalInfoTextStyle,
          ),
          if (details.moreInfoUrl case final moreInfoUrl?)
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
                          title: context.l10n.depositTitle.toUpperCase(),
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
          if (details.referenceNumber case final referenceNumber?)
            Text(
              'Reference number: $referenceNumber',
              style: _additionalInfoTextStyle,
            ),
        ],
      );
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.status,
    this.amount,
    this.manualDeposit,
    required this.created,
    required this.partner,
    this.receiveAmount,
  });

  final OnRampOrderStatus status;
  final Amount? amount;
  final DepositDetails? manualDeposit;
  final RampPartner partner;
  final DateTime created;
  final Amount? receiveAmount;

  @override
  Widget build(BuildContext context) {
    final manualDeposit = this.manualDeposit;
    final isManualBankTransfer = manualDeposit != null;
    final CpTimelineStatus timelineStatus = status.toTimelineStatus();
    final animated = timelineStatus == CpTimelineStatus.inProgress;
    final int activeItem = status.toActiveItem();

    final depositInitiated = CpTimelineItem(
      title: context.l10n.onRampDepositInitiated,
      trailing: amount?.format(context.locale, maxDecimals: 2),
      subtitle: context.formatDate(created),
    );
    final amountReceived = CpTimelineItem(
      title: context.l10n.onRampDepositReceived,
      trailing: receiveAmount?.format(context.locale, maxDecimals: 2),
    );

    CpTimelineItem? deposited;
    if (isManualBankTransfer) {
      deposited = CpTimelineItem(
        title: partner == RampPartner.moneygram
            ? 'Deposited to MoneyGram'
            : context.l10n.onRampLocalTransferTile(
                manualDeposit.transferAmount.format(context.locale),
                manualDeposit.bankName,
                manualDeposit.bankAccount,
              ),
      );
    }

    final items = [
      depositInitiated,
      if (deposited != null) deposited,
      amountReceived,
    ];

    return CpTimeline(
      status: timelineStatus,
      items: items,
      active: isManualBankTransfer ? activeItem + 1 : activeItem,
      animated: animated,
    );
  }
}

extension on OnRampOrderStatus {
  CpStatusType toStatusType() => switch (this) {
        OnRampOrderStatus.pending ||
        OnRampOrderStatus.preProcessing ||
        OnRampOrderStatus.postProcessing ||
        OnRampOrderStatus.waitingForBridge ||
        OnRampOrderStatus.waitingForDeposit ||
        OnRampOrderStatus.waitingForPartner =>
          CpStatusType.info,
        OnRampOrderStatus.depositExpired ||
        OnRampOrderStatus.failure =>
          CpStatusType.error,
        OnRampOrderStatus.completed => CpStatusType.success,
      };

  CpTimelineStatus toTimelineStatus() => switch (this) {
        OnRampOrderStatus.pending ||
        OnRampOrderStatus.preProcessing ||
        OnRampOrderStatus.postProcessing ||
        OnRampOrderStatus.waitingForBridge ||
        OnRampOrderStatus.waitingForDeposit ||
        OnRampOrderStatus.waitingForPartner =>
          CpTimelineStatus.inProgress,
        OnRampOrderStatus.depositExpired ||
        OnRampOrderStatus.failure =>
          CpTimelineStatus.failure,
        OnRampOrderStatus.completed => CpTimelineStatus.success,
      };

  int toActiveItem() => switch (this) {
        OnRampOrderStatus.pending ||
        OnRampOrderStatus.preProcessing ||
        OnRampOrderStatus.depositExpired ||
        OnRampOrderStatus.waitingForDeposit =>
          0,
        OnRampOrderStatus.waitingForPartner ||
        OnRampOrderStatus.postProcessing ||
        OnRampOrderStatus.waitingForBridge ||
        OnRampOrderStatus.failure ||
        OnRampOrderStatus.completed =>
          1,
      };

  String toMoneygramStatus() => switch (this) {
        OnRampOrderStatus.pending ||
        OnRampOrderStatus.preProcessing ||
        OnRampOrderStatus.waitingForBridge ||
        OnRampOrderStatus.waitingForDeposit ||
        OnRampOrderStatus.postProcessing ||
        OnRampOrderStatus.waitingForPartner =>
          'Pending',
        OnRampOrderStatus.depositExpired => 'Expired',
        OnRampOrderStatus.failure => 'Failed',
        OnRampOrderStatus.completed => 'Completed',
      };
}

const _contentSubtitleTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.23,
);

const _additionalInfoTextStyle = TextStyle(
  color: Color(0xFF979593),
  fontSize: 14,
);

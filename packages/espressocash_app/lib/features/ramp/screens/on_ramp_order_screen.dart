import 'package:dfunc/dfunc.dart';
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
import '../../../ui/timeline.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../intercom/services/intercom_service.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../data/on_ramp_order_service.dart';
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

    if (order.status == OnRampOrderStatus.waitingForDeposit &&
        isManualBankTransfer) {
      return OnRampDepositWidget(
        deposit: (
          bankAccount: manualDeposit.bankAccount,
          bankName: manualDeposit.bankName,
          transferExpiryDate: manualDeposit.transferExpiryDate,
          transferAmount: manualDeposit.transferAmount,
          orderId: order.id,
          orderCreated: order.created,
          receiveAmount: order.receiveAmount,
        ),
      );
    }

    final locale = DeviceLocale.localeOf(context);
    final amount = order.receiveAmount ?? order.submittedAmount;

    final String? statusTitle = order.status == OnRampOrderStatus.completed
        ? context.l10n.transferSuccessTitle
        : null;

    final String statusContent = switch (order.status) {
      OnRampOrderStatus.waitingForDeposit ||
      OnRampOrderStatus.waitingForPartner =>
        context.l10n
            .onRampDepositOngoing(amount.format(locale, maxDecimals: 2)),
      OnRampOrderStatus.depositExpired => context.l10n.onRampDepositExpired,
      OnRampOrderStatus.failure => context.l10n.onRampDepositFailure,
      OnRampOrderStatus.completed => context.l10n.onRampDepositSuccess,
    };

    final String? statusSubtitle =
        order.status == OnRampOrderStatus.waitingForPartner
            ? context.l10n.onRampAwaitingFunds
            : null;

    final Widget? primaryButton = order.status == OnRampOrderStatus.failure
        ? const _ContactUsButton()
        : null;

    return StatusScreen(
      title: context.l10n.onRampDepositTitle.toUpperCase(),
      statusType: order.status.toStatusType(),
      statusTitle: statusTitle?.let(Text.new),
      statusContent: Column(
        children: [
          Text(statusContent),
          if (statusSubtitle != null) ...[
            const SizedBox(height: 8),
            Text(
              statusSubtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.23,
              ),
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
              amount: order.submittedAmount,
              manualDeposit: manualDeposit,
              created: order.created,
            ),
            const Spacer(flex: 4),
            PartnerOrderIdWidget(orderId: order.partnerOrderId),
            if (primaryButton != null) ...[
              const SizedBox(height: 12),
              primaryButton,
            ],
            Opacity(
              opacity: order.status == OnRampOrderStatus.depositExpired ? 1 : 0,
              child: _CancelButton(orderId: order.id),
            ),
          ],
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
        padding: EdgeInsets.only(
          top: 24,
          bottom: MediaQuery.paddingOf(context).bottom + 16,
        ),
        child: CpTextButton(
          text: context.l10n.outgoingSplitKeyPayments_btnCancel,
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
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.paddingOf(context).bottom + 16,
        ),
        child: CpButton(
          size: CpButtonSize.big,
          width: double.infinity,
          text: context.l10n.contactUs,
          onPressed: () => sl<IntercomService>().displayMessenger(),
        ),
      );
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.status,
    this.amount,
    this.manualDeposit,
    required this.created,
  });

  final OnRampOrderStatus status;
  final CryptoAmount? amount;
  final DepositDetails? manualDeposit;
  final DateTime created;

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
    );

    final items = [
      depositInitiated,
      if (isManualBankTransfer)
        CpTimelineItem(
          title: context.l10n.onRampLocalTransferTile(
            manualDeposit.transferAmount.format(context.locale),
            manualDeposit.bankName,
            manualDeposit.bankAccount,
          ),
        ),
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
        OnRampOrderStatus.waitingForDeposit ||
        OnRampOrderStatus.waitingForPartner =>
          CpStatusType.info,
        OnRampOrderStatus.depositExpired ||
        OnRampOrderStatus.failure =>
          CpStatusType.error,
        OnRampOrderStatus.completed => CpStatusType.success,
      };

  CpTimelineStatus toTimelineStatus() => switch (this) {
        OnRampOrderStatus.waitingForDeposit ||
        OnRampOrderStatus.waitingForPartner =>
          CpTimelineStatus.inProgress,
        OnRampOrderStatus.depositExpired ||
        OnRampOrderStatus.failure =>
          CpTimelineStatus.failure,
        OnRampOrderStatus.completed => CpTimelineStatus.success,
      };

  int toActiveItem() => switch (this) {
        OnRampOrderStatus.depositExpired ||
        OnRampOrderStatus.waitingForDeposit =>
          0,
        OnRampOrderStatus.waitingForPartner ||
        OnRampOrderStatus.failure ||
        OnRampOrderStatus.completed =>
          1,
      };
}

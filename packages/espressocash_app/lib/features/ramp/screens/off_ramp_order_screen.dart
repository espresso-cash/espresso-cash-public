import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../data/db/db.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routes.gr.dart';
import '../../../ui/button.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../../../ui/timeline.dart';
import '../../profile/widgets/extensions.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../services/off_ramp_order_service.dart';
import '../src/widgets/off_ramp_confirmation.dart';

@RoutePage()
class OffRampOrderScreen extends StatefulWidget {
  const OffRampOrderScreen({super.key, required this.orderId});

  final String orderId;

  static const route = OffRampOrderRoute.new;

  @override
  State<OffRampOrderScreen> createState() => _OffRampOrderScreenState();
}

class _OffRampOrderScreenState extends State<OffRampOrderScreen> {
  late final Stream<OffRampOrder> _stream;
  StreamSubscription<void>? _confirmationSubscription;

  @override
  void initState() {
    super.initState();
    _stream = sl<OffRampOrderService>().watch(widget.orderId);
  }

  @override
  void dispose() {
    _confirmationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          final order = snapshot.data;
          final locale = DeviceLocale.localeOf(context);

          if (order == null) {
            return TransferProgress(onBack: () => context.router.pop());
          } else if (order.status == OffRampOrderStatus.depositTxRequired) {
            return OffRampConfirmation(order: order);
          }

          void onCancel() => showConfirmationDialog(
                context,
                title: context.l10n.offRampCancelTitle,
                message: context.l10n.offRampCancelSubtitle,
                onConfirm: () {
                  sl<OffRampOrderService>().cancel(widget.orderId);
                },
              );

          final retryButton = CpButton(
            size: CpButtonSize.big,
            width: double.infinity,
            text: context.l10n.retry,
            onPressed: () {
              sl<OffRampOrderService>().retry(widget.orderId);
            },
          );

          final contactUsButton = Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom + 16,
            ),
            child: CpButton(
              size: CpButtonSize.big,
              width: double.infinity,
              text: context.l10n.contactUs,
              onPressed: context.launchContactUs,
            ),
          );

          final cancelButton = Padding(
            padding: EdgeInsets.only(
              top: 24,
              bottom: MediaQuery.paddingOf(context).bottom + 16,
            ),
            child: CpTextButton(
              text: context.l10n.outgoingSplitKeyPayments_btnCancel,
              variant: CpTextButtonVariant.light,
              onPressed: onCancel,
            ),
          );

          final CpStatusType statusType = switch (order.status) {
            OffRampOrderStatus.depositTxRequired ||
            OffRampOrderStatus.creatingDepositTx ||
            OffRampOrderStatus.depositTxReady ||
            OffRampOrderStatus.sendingDepositTx ||
            OffRampOrderStatus.waitingForPartner =>
              CpStatusType.info,
            OffRampOrderStatus.depositError ||
            OffRampOrderStatus.depositTxConfirmError ||
            OffRampOrderStatus.failure =>
              CpStatusType.error,
            OffRampOrderStatus.completed => CpStatusType.success,
            OffRampOrderStatus.cancelled => CpStatusType.neutral,
          };

          final String? statusTitle =
              order.status == OffRampOrderStatus.completed
                  ? context.l10n.transferSuccessTitle
                  : null;

          final String statusContent = switch (order.status) {
            OffRampOrderStatus.depositTxRequired ||
            OffRampOrderStatus.creatingDepositTx ||
            OffRampOrderStatus.depositTxReady ||
            OffRampOrderStatus.sendingDepositTx =>
              context.l10n.offRampWithdrawOngoing(
                order.amount.format(locale),
              ),
            OffRampOrderStatus.waitingForPartner =>
              context.l10n.offRampWaitingForPartner,
            OffRampOrderStatus.depositTxConfirmError ||
            OffRampOrderStatus.depositError =>
              context.l10n.offRampDepositError,
            OffRampOrderStatus.failure => context.l10n.offRampWithdrawalFailure,
            OffRampOrderStatus.completed => context.l10n.offRampWithdrawSuccess,
            OffRampOrderStatus.cancelled =>
              context.l10n.offRampWithdrawCancelled(
                order.amount.format(locale),
              ),
          };

          final CpTimelineStatus timelineStatus = switch (order.status) {
            OffRampOrderStatus.depositTxRequired ||
            OffRampOrderStatus.creatingDepositTx ||
            OffRampOrderStatus.depositTxReady ||
            OffRampOrderStatus.sendingDepositTx ||
            OffRampOrderStatus.waitingForPartner =>
              CpTimelineStatus.inProgress,
            OffRampOrderStatus.depositTxConfirmError ||
            OffRampOrderStatus.depositError ||
            OffRampOrderStatus.failure =>
              CpTimelineStatus.failure,
            OffRampOrderStatus.completed => CpTimelineStatus.success,
            OffRampOrderStatus.cancelled => CpTimelineStatus.neutral,
          };

          final animated = timelineStatus == CpTimelineStatus.inProgress &&
              order.status != OffRampOrderStatus.waitingForPartner;

          final int activeItem = switch (order.status) {
            OffRampOrderStatus.depositTxRequired ||
            OffRampOrderStatus.creatingDepositTx ||
            OffRampOrderStatus.depositTxReady ||
            OffRampOrderStatus.sendingDepositTx ||
            OffRampOrderStatus.waitingForPartner ||
            OffRampOrderStatus.depositError ||
            OffRampOrderStatus.depositTxConfirmError ||
            OffRampOrderStatus.cancelled =>
              1,
            OffRampOrderStatus.failure || OffRampOrderStatus.completed => 2,
          };

          final withdrawInitiated = CpTimelineItem(
            title: context.l10n.offRampWithdrawInitiated,
            trailing: order.amount.format(locale),
            subtitle: order.created.let((t) => context.formatDate(t)),
          );
          final amountSent = CpTimelineItem(
            title: context.l10n.offRampWithdrawSent,
          );
          final paymentSuccess = CpTimelineItem(
            title: context.l10n.offRampWithdrawReceived,
            subtitle: order.resolved?.let((t) => context.formatDate(t)),
          );
          final paymentCanceled = CpTimelineItem(
            title: context.l10n.offRampWithdrawCancelledTitle,
            subtitle: order.resolved?.let((t) => context.formatDate(t)),
          );

          final normalItems = [
            withdrawInitiated,
            amountSent,
            paymentSuccess,
          ];
          final cancelingItems = [
            withdrawInitiated,
            paymentCanceled,
          ];

          final items = order.status == OffRampOrderStatus.cancelled
              ? cancelingItems
              : normalItems;

          final List<Widget> actions = switch (order.status) {
            OffRampOrderStatus.depositError => [retryButton, cancelButton],
            OffRampOrderStatus.depositTxConfirmError => [retryButton],
            OffRampOrderStatus.failure => [contactUsButton],
            OffRampOrderStatus.depositTxRequired ||
            OffRampOrderStatus.creatingDepositTx ||
            OffRampOrderStatus.depositTxReady ||
            OffRampOrderStatus.sendingDepositTx ||
            OffRampOrderStatus.waitingForPartner ||
            OffRampOrderStatus.completed ||
            OffRampOrderStatus.cancelled =>
              const [],
          };

          return StatusScreen(
            title: context.l10n.offRampWithdrawTitle.toUpperCase(),
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

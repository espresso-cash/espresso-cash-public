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
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/timeline.dart';
import '../../profile/widgets/extensions.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../data/on_ramp_order_service.dart';
import '../src/widgets/on_ramp_deposit_screen.dart';

@RoutePage()
class OnRampOrderScreen extends StatefulWidget {
  const OnRampOrderScreen({super.key, required this.orderId});

  final String orderId;

  static const route = OnRampOrderRoute.new;

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
              ? TransferProgress(onBack: () => context.router.pop())
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
    if (order.status == OnRampOrderStatus.waitingForDeposit) {
      return OnRampDepositScreen(order: order);
    }

    final locale = DeviceLocale.localeOf(context);
    final amount =
        order.amount.let((e) => e?.value != 0 ? e : order.receiveAmount);

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

    final CpStatusType statusType = switch (order.status) {
      OnRampOrderStatus.waitingForDeposit ||
      OnRampOrderStatus.waitingForPartner =>
        CpStatusType.info,
      OnRampOrderStatus.failure => CpStatusType.error,
      OnRampOrderStatus.completed => CpStatusType.success,
    };

    final String? statusTitle = order.status == OnRampOrderStatus.completed
        ? context.l10n.transferSuccessTitle
        : null;

    final String statusContent = switch (order.status) {
      OnRampOrderStatus.waitingForDeposit ||
      OnRampOrderStatus.waitingForPartner =>
        context.l10n.onRampDepositOngoing(
          amount?.format(locale, maxDecimals: 2) ?? 'USDC',
        ),
      OnRampOrderStatus.failure => context.l10n.onRampDepositFailure,
      OnRampOrderStatus.completed => context.l10n.onRampDepositSuccess,
    };

    final CpTimelineStatus timelineStatus = switch (order.status) {
      OnRampOrderStatus.waitingForDeposit ||
      OnRampOrderStatus.waitingForPartner =>
        CpTimelineStatus.inProgress,
      OnRampOrderStatus.failure => CpTimelineStatus.failure,
      OnRampOrderStatus.completed => CpTimelineStatus.success,
    };

    final int activeItem = switch (order.status) {
      OnRampOrderStatus.waitingForDeposit ||
      OnRampOrderStatus.waitingForPartner =>
        0,
      OnRampOrderStatus.failure || OnRampOrderStatus.completed => 1,
    };

    final depositInitiated = CpTimelineItem(
      title: context.l10n.onRampDepositInitiated,
      trailing: amount?.format(locale, maxDecimals: 2),
      subtitle: order.created.let((t) => context.formatDate(t)),
    );
    final amountReceived = CpTimelineItem(
      title: context.l10n.onRampDepositReceived,
    );

    final items = [
      depositInitiated,
      amountReceived,
    ];

    final Widget? primaryButton =
        order.status == OnRampOrderStatus.failure ? contactUsButton : null;

    return StatusScreen(
      title: context.l10n.onRampDepositTitle.toUpperCase(),
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
              animated: false,
            ),
            const Spacer(flex: 4),
            SizedBox(
              height: CpButtonSize.big.height,
              child: Center(
                child: Text(
                  context.l10n.orderId(order.partnerOrderId),
                  style: const TextStyle(
                    color: Color(0xFF979593),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            if (primaryButton != null) ...[
              const SizedBox(height: 12),
              primaryButton,
            ],
          ],
        ),
      ),
    );
  }
}

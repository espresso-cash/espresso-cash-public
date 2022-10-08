import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/bloc.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/outgoing_split_key_payment.dart';
import 'package:cryptoplease/features/outgoing_split_key_payments/bl/repository.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OSKPScreen extends StatefulWidget {
  const OSKPScreen({super.key, required this.id});

  final String id;

  @override
  State<OSKPScreen> createState() => _OSKPScreenState();
}

class _OSKPScreenState extends State<OSKPScreen> {
  late final Stream<OutgoingSplitKeyPayment?> _payment;

  @override
  void initState() {
    super.initState();
    _payment = context.read<OSKPRepository>().watch(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingSplitKeyPayment?>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;
          final locale = DeviceLocale.localeOf(context);

          final SvgGenImage logo = payment?.status.mapOrNull(
                success: always(Assets.icons.logoBgGreen),
                txFailure: always(Assets.icons.logoBgRed),
                txSendFailure: always(Assets.icons.logoBgRed),
                txWaitFailure: always(Assets.icons.logoBgRed),
                txLinksFailure: always(Assets.icons.logoBgRed),
              ) ??
              Assets.icons.logoBgOrange;

          final CpStatusType statusType = payment?.status.mapOrNull(
                success: always(CpStatusType.success),
                txFailure: always(CpStatusType.error),
                txSendFailure: always(CpStatusType.error),
                txWaitFailure: always(CpStatusType.error),
                txLinksFailure: always(CpStatusType.error),
              ) ??
              CpStatusType.info;

          final String? statusTitle = payment?.status.mapOrNull(
            success: always(context.l10n.splitKeySuccessMessage1),
          );

          final String statusContent = payment == null
              ? context.l10n.loading
              : payment.status.maybeMap(
                  success: always(context.l10n.splitKeySuccessMessage2),
                  txFailure: always(context.l10n.splitKeyErrorMessage2),
                  txSendFailure: always(context.l10n.splitKeyErrorMessage2),
                  txWaitFailure: always(context.l10n.splitKeyErrorMessage2),
                  txLinksFailure: always(context.l10n.splitKeyErrorMessage2),
                  orElse: always(
                    context.l10n.splitKeyProgressOngoing(
                      payment.amount.format(locale),
                    ),
                  ),
                );

          final CpTimelineStatus timelineStatus = payment?.status.mapOrNull(
                success: always(CpTimelineStatus.success),
                txFailure: always(CpTimelineStatus.failure),
                txSendFailure: always(CpTimelineStatus.failure),
                txWaitFailure: always(CpTimelineStatus.failure),
                txLinksFailure: always(CpTimelineStatus.failure),
              ) ??
              CpTimelineStatus.inProgress;

          final int activeItem = payment?.status.mapOrNull(
                success: always(2),
                linksReady: always(1),
              ) ??
              0;

          final creatingLinks = CpTimelineItem(title: 'Creating links');
          final linksCreated = CpTimelineItem(
            title: context.l10n.splitKeyProgressCreated,
            trailing: payment?.amount.format(locale),
          );
          final waitingForReceiver = CpTimelineItem(
            title: context.l10n.splitKeyProgressWaiting,
          );
          final fundsWithdrawn = CpTimelineItem(
            title: context.l10n.splitKeyProgressWithdrawn,
          );
          final paymentSuccess = CpTimelineItem(
            title: context.l10n.splitKeyProgressSuccess,
          );

          final items = payment?.status.mapOrNull(
                success: always([
                  creatingLinks,
                  fundsWithdrawn,
                  paymentSuccess,
                ]),
                linksReady: always([
                  linksCreated,
                  waitingForReceiver,
                  paymentSuccess,
                ]),
              ) ??
              [
                creatingLinks,
                waitingForReceiver,
                paymentSuccess,
              ];

          return StatusScreen(
            onBackButtonPressed: () => context.router.pop(),
            title: context.l10n.splitKeyTransferTitle,
            statusType: statusType,
            backgroundImage: logo.svg(alignment: Alignment.bottomCenter),
            statusTitle: statusTitle?.let(Text.new),
            statusContent: Text(statusContent),
            content: CpContentPadding(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Expanded(
                    child: CpTimeline(
                      status: timelineStatus,
                      items: items,
                      active: activeItem,
                    ),
                  ),
                  if (payment != null && payment.shouldRetry)
                    CpButton(
                      size: CpButtonSize.big,
                      width: double.infinity,
                      text: context.l10n.retry,
                      onPressed: () => context
                          .read<OSKPBloc>()
                          .add(OSKPEvent.process(payment.id)),
                    ),
                  if (payment != null && payment.shouldShareLinks)
                    CpButton(
                      size: CpButtonSize.big,
                      width: double.infinity,
                      text: context.l10n.resendLink,
                      onPressed: () {
                        // TODO(KB): Implement
                      },
                    ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          );
        },
      );
}

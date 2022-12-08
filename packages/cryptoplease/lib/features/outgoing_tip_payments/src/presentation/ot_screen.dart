import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../di.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/status_screen.dart';
import '../../../../ui/status_widget.dart';
import '../../../../ui/timeline.dart';
import '../bl/bloc.dart';
import '../bl/outgoing_tip_payment.dart';
import '../bl/repository.dart';

class OutgoingTipScreen extends StatefulWidget {
  const OutgoingTipScreen({super.key, required this.id});

  final String id;

  @override
  State<OutgoingTipScreen> createState() => _OutgoingTipScreenState();
}

class _OutgoingTipScreenState extends State<OutgoingTipScreen> {
  late final Stream<OutgoingTipPayment?> _payment;
  StreamSubscription<void>? _shareLinksSubscription;

  @override
  void initState() {
    super.initState();
    final repository = sl<OTRepository>();
    _payment = repository.watch(widget.id);

    _shareLinksSubscription = repository
        .watch(widget.id)
        .skip(1)
        .where((payment) => payment?.status is OutgoingTipLinkReady)
        .listen((payment) {
      if (payment == null) throw StateError('Payment is null');

      final status = payment.status as OutgoingTipLinkReady;

      context.router.push(ShareQRRoute(amount: payment.amount, status: status));
      _shareLinksSubscription?.cancel();
    });
  }

  @override
  void dispose() {
    _shareLinksSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingTipPayment?>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;
          final locale = DeviceLocale.localeOf(context);

          final isProcessing = payment != null &&
              context.watch<OTBloc>().state.contains(payment.id);

          final CpStatusType statusType = isProcessing
              ? CpStatusType.info
              : payment?.status.mapOrNull(
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
                  txFailure: (it) => [
                    context.l10n.splitKeyErrorMessage2,
                    if (it.reason == TxFailureReason.insufficientFunds)
                      context.l10n.errorMessageInsufficientFunds,
                  ].join(' '),
                  txSendFailure: always(context.l10n.splitKeyErrorMessage2),
                  txWaitFailure: always(context.l10n.splitKeyErrorMessage2),
                  txLinksFailure: always(context.l10n.splitKeyErrorMessage2),
                  orElse: always(
                    context.l10n.splitKeyProgressOngoing(
                      payment.amount.format(locale),
                    ),
                  ),
                );

          final CpTimelineStatus timelineStatus = isProcessing
              ? CpTimelineStatus.inProgress
              : payment?.status.mapOrNull(
                    success: always(CpTimelineStatus.success),
                    txFailure: always(CpTimelineStatus.failure),
                    txSendFailure: always(CpTimelineStatus.failure),
                    txWaitFailure: always(CpTimelineStatus.failure),
                    txLinksFailure: always(CpTimelineStatus.failure),
                  ) ??
                  CpTimelineStatus.inProgress;

          final int activeItem = payment?.status.mapOrNull(
                success: always(2),
                linkReady: always(1),
              ) ??
              0;

          final creatingLink = CpTimelineItem(
            title: context.l10n.tipCreatingQr,
            trailing: payment?.amount.format(locale),
          );
          final linkCreated = CpTimelineItem(
            title: context.l10n.tipCreatedQr,
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
                  creatingLink,
                  fundsWithdrawn,
                  paymentSuccess,
                ]),
                linkReady: always([
                  linkCreated,
                  waitingForReceiver,
                  paymentSuccess,
                ]),
              ) ??
              [
                creatingLink,
                waitingForReceiver,
                paymentSuccess,
              ];

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
                  ),
                  const Spacer(flex: 4),
                  if (payment != null && payment.shouldRetry)
                    CpButton(
                      size: CpButtonSize.big,
                      width: double.infinity,
                      text: context.l10n.retry,
                      onPressed: isProcessing
                          ? null
                          : () => context
                              .read<OTBloc>()
                              .add(OTEvent.process(payment.id)),
                    ),
                  if (payment != null)
                    ...payment.status.mapOrNull(
                          linkReady: (s) => [
                            CpButton(
                              size: CpButtonSize.big,
                              width: double.infinity,
                              text: context.l10n.tipViewQr,
                              onPressed: () => context.router.push(
                                ShareQRRoute(
                                  amount: payment.amount,
                                  status: s,
                                ),
                              ),
                            )
                          ],
                        ) ??
                        [],
                ],
              ),
            ),
          );
        },
      );
}

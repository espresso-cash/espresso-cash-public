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
import '../../../../ui/text_button.dart';
import '../../../../ui/timeline.dart';
import '../../../cancel_outgoing_payment/cancel_payment.dart';
import '../../models/outgoing_split_key_payment.dart';
import '../bl/bloc.dart';
import '../bl/repository.dart';

class OSKPScreen extends StatefulWidget {
  const OSKPScreen({super.key, required this.id});

  final String id;

  @override
  State<OSKPScreen> createState() => _OSKPScreenState();
}

class _OSKPScreenState extends State<OSKPScreen> {
  late final Stream<OutgoingSplitKeyPayment?> _payment;
  StreamSubscription<void>? _shareLinksSubscription;

  @override
  void initState() {
    super.initState();
    final repository = sl<OSKPRepository>();
    _payment = repository.watch(widget.id);

    _shareLinksSubscription = repository
        .watch(widget.id)
        .skip(1)
        .where((payment) => payment?.status is OSKPStatusLinksReady)
        .listen((payment) {
      if (payment == null) throw StateError('Payment is null');

      final status = payment.status as OSKPStatusLinksReady;

      context.router
          .push(ShareLinksRoute(amount: payment.amount, status: status));
      _shareLinksSubscription?.cancel();
    });
  }

  @override
  void dispose() {
    _shareLinksSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingSplitKeyPayment?>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;
          final locale = DeviceLocale.localeOf(context);

          final isProcessing = payment != null &&
              context.watch<OSKPBloc>().state.contains(payment.id);

          final paymentId = payment?.id;
          final escrow = payment?.status.mapOrNull(
            txCreated: (it) => it.escrow,
            txSent: (it) => it.escrow,
            txConfirmed: (it) => it.escrow,
            linksReady: (it) => it.escrow,
            txSendFailure: (it) => it.escrow,
            txWaitFailure: (it) => it.escrow,
            txLinksFailure: (it) => it.escrow,
          );

          final CpStatusType statusType = isProcessing
              ? CpStatusType.info
              : payment?.status.mapOrNull(
                    withdrawn: always(CpStatusType.success),
                    canceled: always(CpStatusType.error),
                    txFailure: always(CpStatusType.error),
                    txSendFailure: always(CpStatusType.error),
                    txWaitFailure: always(CpStatusType.error),
                    txLinksFailure: always(CpStatusType.error),
                  ) ??
                  CpStatusType.info;

          final String? statusTitle = payment?.status.mapOrNull(
            withdrawn: always(context.l10n.transferSuccessTitle),
          );

          final String statusContent = payment == null
              ? context.l10n.loading
              : payment.status.maybeMap(
                  withdrawn: always(context.l10n.outgoingTransferSuccess),
                  canceled: always(
                    context.l10n.splitKeyCanceledMessage1(
                      payment.amount.format(locale),
                    ),
                  ),
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
                    withdrawn: always(CpTimelineStatus.success),
                    canceled: always(CpTimelineStatus.failure),
                    txFailure: always(CpTimelineStatus.failure),
                    txSendFailure: always(CpTimelineStatus.failure),
                    txWaitFailure: always(CpTimelineStatus.failure),
                    txLinksFailure: always(CpTimelineStatus.failure),
                  ) ??
                  CpTimelineStatus.inProgress;

          final int activeItem = payment?.status.mapOrNull(
                withdrawn: always(2),
                canceled: always(1),
                linksReady: always(1),
              ) ??
              0;

          final creatingLinks = CpTimelineItem(
            title: 'Creating links',
            trailing: payment?.amount.format(locale),
          );
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
          final paymentCanceled = CpTimelineItem(
            title: context.l10n.splitKeyProgressCanceled,
          );

          final items = payment?.status.mapOrNull(
                withdrawn: always([
                  linksCreated,
                  fundsWithdrawn,
                  paymentSuccess,
                ]),
                canceled: always([
                  linksCreated,
                  paymentCanceled,
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
                              .read<OSKPBloc>()
                              .add(OSKPEvent.process(payment.id)),
                    ),
                  if (payment != null)
                    ...payment.status.mapOrNull(
                          linksReady: (s) => [
                            CpButton(
                              size: CpButtonSize.big,
                              width: double.infinity,
                              text: context.l10n.resendLink,
                              onPressed: () => context.router.push(
                                ShareLinksRoute(
                                  amount: payment.amount,
                                  status: s,
                                ),
                              ),
                            ),
                          ],
                        ) ??
                        [],
                  if (escrow != null && paymentId != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: CpTextButton(
                        text: context.l10n.cancelTransfer,
                        variant: CpTextButtonVariant.light,
                        onPressed: () =>
                            context.cancelOutgoingPayment(paymentId, escrow),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
}

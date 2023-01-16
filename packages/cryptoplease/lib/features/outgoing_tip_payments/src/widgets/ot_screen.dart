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
import '../../models/outgoing_tip_payment.dart';
import '../bl/bloc.dart';
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
        .where((payment) => payment?.status is OTLinkReady)
        .listen((payment) {
      if (payment == null) throw StateError('Payment is null');

      final status = payment.status as OTLinkReady;

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

          final isCancelable = payment
              .maybeFlatMap(
                (it) => it.status.maybeMap(
                  orElse: T,
                  txFailure: F,
                  withdrawn: F,
                  canceled: F,
                ),
              )
              .ifNull(F);

          final CpStatusType statusType = isProcessing
              ? CpStatusType.info
              : payment?.status.mapOrNull(
                    withdrawn: always(CpStatusType.success),
                    canceled: always(CpStatusType.error),
                    txFailure: always(CpStatusType.error),
                    txSendFailure: always(CpStatusType.error),
                    txWaitFailure: always(CpStatusType.error),
                    txLinksFailure: always(CpStatusType.error),
                    cancelTxFailure: always(CpStatusType.error),
                    cancelTxSendFailure: always(CpStatusType.error),
                    cancelTxWaitFailure: always(CpStatusType.error),
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
                    context.l10n.tipCanceledMessage(
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
                  cancelTxCreated:
                      always(context.l10n.splitKeyProgressCanceling),
                  cancelTxSent: always(context.l10n.splitKeyProgressCanceling),
                  cancelTxSendFailure:
                      always(context.l10n.splitKeyCancelErrorMessage),
                  cancelTxWaitFailure:
                      always(context.l10n.splitKeyCancelErrorMessage),
                  cancelTxFailure: (it) => [
                    context.l10n.splitKeyCancelErrorMessage,
                    if (it.reason == TxFailureReason.insufficientFunds)
                      context.l10n.cancelErrorMessageInsufficientFunds,
                  ].join(' '),
                  orElse: always(
                    context.l10n.tipProgressOngoing(
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
                    cancelTxFailure: always(CpTimelineStatus.failure),
                    cancelTxSendFailure: always(CpTimelineStatus.failure),
                    cancelTxWaitFailure: always(CpTimelineStatus.failure),
                  ) ??
                  CpTimelineStatus.inProgress;

          final int activeItem = payment?.status.mapOrNull(
                withdrawn: always(2),
                linkReady: always(1),
                canceled: always(1),
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
          final paymentCanceled = CpTimelineItem(
            title: context.l10n.tipProgressCanceled,
          );

          final cancelingItems = [
            linkCreated,
            paymentCanceled,
          ];

          final items = payment?.status.mapOrNull(
                withdrawn: always([
                  linkCreated,
                  fundsWithdrawn,
                  paymentSuccess,
                ]),
                linkReady: always([
                  linkCreated,
                  waitingForReceiver,
                  paymentSuccess,
                ]),
                canceled: always(cancelingItems),
                cancelTxCreated: always(cancelingItems),
                cancelTxFailure: always(cancelingItems),
                cancelTxSendFailure: always(cancelingItems),
                cancelTxSent: always(cancelingItems),
                cancelTxWaitFailure: always(cancelingItems),
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
                  if (!isProcessing && isCancelable && payment != null)
                    Padding(
                      padding: EdgeInsets.only(
                        top: 24,
                        bottom: MediaQuery.of(context).padding.bottom + 16,
                      ),
                      child: CpTextButton(
                        text: context.l10n.cancelTip,
                        variant: CpTextButtonVariant.light,
                        onPressed: () => context
                            .read<OTBloc>()
                            .add(OTEvent.cancel(payment.id)),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
}

import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../../../ui/timeline.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../transactions/models/tx_results.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../data/repository.dart';
import '../models/outgoing_link_payment.dart';
import '../widgets/extensions.dart';
import 'share_link_screen.dart';

class OLPScreen extends StatefulWidget {
  const OLPScreen({super.key, required this.id});

  static void push(BuildContext context, {required String id}) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => OLPScreen(id: id),
        ),
      );

  static void open(BuildContext context, {required String id}) =>
      Navigator.of(context).pushAndRemoveUntil<void>(
        MaterialPageRoute(
          builder: (context) => OLPScreen(id: id),
        ),
        (route) => route.isFirst,
      );

  final String id;

  @override
  State<OLPScreen> createState() => _OLPScreenState();
}

class _OLPScreenState extends State<OLPScreen> {
  late final Stream<OutgoingLinkPayment> _payment;
  StreamSubscription<void>? _shareLinkSubscription;

  @override
  void initState() {
    super.initState();
    final repository = sl<OLPRepository>();
    _payment = repository.watch(widget.id);

    _shareLinkSubscription = repository
        .watch(widget.id)
        .skip(1)
        .where((payment) => payment.status is OLPStatusLinkReady)
        .listen((payment) {
      final status = payment.status as OLPStatusLinkReady;

      ShareLinkScreen.push(context, amount: payment.amount, status: status);
      _shareLinkSubscription?.cancel();
    });
  }

  @override
  void dispose() {
    _shareLinkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingLinkPayment>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;
          final locale = DeviceLocale.localeOf(context);

          if (payment == null) {
            return TransferProgress(onBack: () => Navigator.pop(context));
          }

          void handleCanceled() => showConfirmationDialog(
                context,
                title: context
                    .l10n.outgoingSplitKeyPayments_lblCancelConfirmationTitle
                    .toUpperCase(),
                message: context.l10n
                    .outgoingSplitKeyPayments_lblCancelConfirmationSubtitle,
                onConfirm: () {
                  context.cancelOLP(payment: payment);
                },
              );

          final cancelButton = Padding(
            padding: EdgeInsets.only(
              top: 24,
              bottom: MediaQuery.paddingOf(context).bottom + 16,
            ),
            child: CpTextButton(
              text: context.l10n.outgoingSplitKeyPayments_btnCancel,
              variant: CpTextButtonVariant.dark,
              onPressed: handleCanceled,
            ),
          );

          final created = payment.created;
          final generatedLinksAt = payment.linksGeneratedAt;
          final resolvedAt = payment.status.mapOrNull(
            canceled: (e) => e.timestamp,
            withdrawn: (e) => e.timestamp,
          );

          final List<Widget> actions = payment.status.maybeMap(
            linkReady: (s) => [
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.resendLink,
                onPressed: () => ShareLinkScreen.push(
                  context,
                  amount: payment.amount,
                  status: s,
                ),
              ),
              cancelButton,
            ],
            txFailure: (s) => [
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.retry,
                onPressed: () => context.retryOLP(payment: payment),
              ),
              cancelButton,
            ],
            cancelTxFailure: (s) => [
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.retry,
                onPressed: handleCanceled,
              ),
            ],
            orElse: () => const [],
          );

          final CpStatusType statusType = payment.status.map(
            txCreated: always(CpStatusType.info),
            txSent: always(CpStatusType.info),
            linkReady: always(CpStatusType.info),
            withdrawn: always(CpStatusType.success),
            canceled: always(CpStatusType.neutral),
            txFailure: always(CpStatusType.error),
            cancelTxCreated: always(CpStatusType.info),
            cancelTxFailure: always(CpStatusType.error),
            cancelTxSent: always(CpStatusType.info),
          );

          final String? statusTitle = payment.status.mapOrNull(
            withdrawn: always(context.l10n.transferSuccessTitle),
          );

          final String statusContent = payment.status.maybeMap(
            withdrawn: always(context.l10n.splitKeySuccessMessage2),
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
            cancelTxCreated: always(context.l10n.splitKeyProgressCanceling),
            cancelTxSent: always(context.l10n.splitKeyProgressCanceling),
            cancelTxFailure: (it) => [
              context.l10n.splitKeyCancelErrorMessage,
              if (it.reason == TxFailureReason.insufficientFunds)
                context.l10n.outgoingSplitKeyPayments_lblMoneyWithdrawn,
            ].join(' '),
            orElse: always(
              context.l10n.splitKeyProgressOngoing(
                payment.amount.format(locale),
              ),
            ),
          );

          final CpTimelineStatus timelineStatus = payment.status.mapOrNull(
                withdrawn: always(CpTimelineStatus.success),
                canceled: always(CpTimelineStatus.neutral),
                txFailure: always(CpTimelineStatus.failure),
                cancelTxFailure: always(CpTimelineStatus.failure),
              ) ??
              CpTimelineStatus.inProgress;

          final int activeItem = payment.status.map(
            cancelTxFailure: always(0),
            txFailure: always(0),
            canceled: always(1),
            txCreated: always(1),
            txSent: always(1),
            cancelTxCreated: always(1),
            cancelTxSent: always(1),
            linkReady: always(1),
            withdrawn: always(2),
          );

          final paymentInitiated = CpTimelineItem(
            title: context.l10n.paymentInitiated,
            trailing: payment.amount.format(locale),
            subtitle: created.let((t) => context.formatDate(t)),
          );
          final linksCreated = CpTimelineItem(
            title: context.l10n.splitKeyProgressCreated,
            subtitle: generatedLinksAt?.let((t) => context.formatDate(t)),
          );
          final paymentSuccess = CpTimelineItem(
            title: context.l10n.splitKeyProgressSuccess,
            subtitle: resolvedAt?.let((t) => context.formatDate(t)),
          );
          final paymentCanceled = CpTimelineItem(
            title: context.l10n.splitKeyProgressCanceled,
            subtitle: resolvedAt?.let((t) => context.formatDate(t)),
          );

          final normalItems = [
            paymentInitiated,
            linksCreated,
            paymentSuccess,
          ];
          final cancelingItems = [
            paymentInitiated,
            paymentCanceled,
          ];

          final items = payment.status.mapOrNull(
                withdrawn: always(normalItems),
                linkReady: always(normalItems),
                canceled: always(cancelingItems),
                cancelTxCreated: always(cancelingItems),
                cancelTxFailure: always(cancelingItems),
                cancelTxSent: always(cancelingItems),
              ) ??
              normalItems;

          final animated = timelineStatus == CpTimelineStatus.inProgress &&
              payment.status.maybeMap(orElse: T, linkReady: F);

          return StatusScreen(
            onBackButtonPressed: () => Navigator.pop(context),
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

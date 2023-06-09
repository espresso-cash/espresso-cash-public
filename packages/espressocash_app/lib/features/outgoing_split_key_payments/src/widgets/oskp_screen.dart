import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../core/transactions/tx_sender.dart';
import '../../../../di.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/dialogs.dart';
import '../../../../ui/status_screen.dart';
import '../../../../ui/status_widget.dart';
import '../../../../ui/text_button.dart';
import '../../../../ui/timeline.dart';
import '../../../../ui/transfer_status/transfer_progress.dart';
import '../../models/outgoing_split_key_payment.dart';
import '../../widgets/extensions.dart';
import '../bl/repository.dart';

@RoutePage()
class OSKPScreen extends StatefulWidget {
  const OSKPScreen({super.key, required this.id});

  final String id;

  @override
  State<OSKPScreen> createState() => _OSKPScreenState();
}

class _OSKPScreenState extends State<OSKPScreen> {
  late final Stream<OutgoingSplitKeyPayment> _payment;
  StreamSubscription<void>? _shareLinksSubscription;

  @override
  void initState() {
    super.initState();
    final repository = sl<OSKPRepository>();
    _payment = repository.watch(widget.id);

    _shareLinksSubscription = repository
        .watch(widget.id)
        .skip(1)
        .where((payment) => payment.status is OSKPStatusLinksReady)
        .listen((payment) {
      final status = payment.status as OSKPStatusLinksReady;

      context.router
          .popAndPush(ShareLinksRoute(amount: payment.amount, status: status));
      _shareLinksSubscription?.cancel();
    });
  }

  @override
  void dispose() {
    _shareLinksSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<OutgoingSplitKeyPayment>(
        stream: _payment,
        builder: (context, snapshot) {
          final payment = snapshot.data;
          final locale = DeviceLocale.localeOf(context);

          if (payment == null) {
            return TransferProgress(onBack: () => context.router.pop());
          }

          void onCancel() => showConfirmationDialog(
                context,
                title: context.l10n.cancelTransferConfirmationTitle,
                message: context.l10n.cancelTransferConfirmationSubtitle,
                onConfirm: () {
                  context.cancelOSKP(payment: payment);
                },
              );

          final cancelButton = Padding(
            padding: EdgeInsets.only(
              top: 24,
              bottom: MediaQuery.of(context).padding.bottom + 16,
            ),
            child: CpTextButton(
              text: context.l10n.cancelTransfer,
              variant: CpTextButtonVariant.light,
              onPressed: onCancel,
            ),
          );

          final created = payment.created;
          final generatedLinksAt = payment.linksGeneratedAt;
          final resolvedAt = payment.status.mapOrNull(
            canceled: (e) => e.timestamp,
            withdrawn: (e) => e.timestamp,
          );

          final List<Widget> actions = payment.status.maybeMap(
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
              cancelButton,
            ],
            txFailure: (s) => [
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.retry,
                onPressed: () => context.retryOSKP(payment: payment),
              ),
              cancelButton,
            ],
            cancelTxFailure: (s) => [
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.retry,
                onPressed: onCancel,
              ),
            ],
            orElse: () => const [],
          );

          final CpStatusType statusType = payment.status.map(
            txCreated: always(CpStatusType.info),
            txSent: always(CpStatusType.info),
            txConfirmed: always(CpStatusType.info),
            linksReady: always(CpStatusType.info),
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
                context.l10n.cancelErrorMessageInsufficientFunds,
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
            txConfirmed: always(1),
            linksReady: always(1),
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
                linksReady: always(normalItems),
                canceled: always(cancelingItems),
                cancelTxCreated: always(cancelingItems),
                cancelTxFailure: always(cancelingItems),
                cancelTxSent: always(cancelingItems),
              ) ??
              normalItems;

          final animated = timelineStatus == CpTimelineStatus.inProgress &&
              payment.status.maybeMap(orElse: T, linksReady: F);

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

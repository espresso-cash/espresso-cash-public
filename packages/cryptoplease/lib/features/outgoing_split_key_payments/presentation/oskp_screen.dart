import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/routes.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/di.dart';
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
                            )
                          ],
                        ) ??
                        [],
                  const SizedBox(height: 60),
                ],
              ),
            ),
          );
        },
      );
}

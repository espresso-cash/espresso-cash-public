import 'dart:async';

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/button.dart';
import '../../../ui/content_padding.dart';
import '../../../ui/dialogs.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../../../ui/theme.dart';
import '../../../ui/timeline.dart';
import '../../../utils/extensions.dart';
import '../../authenticated/authenticated_navigator_key.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token_list.dart';
import '../../transactions/widgets/transfer_progress.dart';
import '../data/repository.dart';
import '../models/payment_request.dart';
import '../widgets/invoice.dart';
import 'share_payment_request_screen.dart';

class RequestPaymentStatusScreen extends StatefulWidget {
  const RequestPaymentStatusScreen({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<RequestPaymentStatusScreen> createState() =>
      _RequestPaymentStatusScreenState();
}

class _RequestPaymentStatusScreenState
    extends State<RequestPaymentStatusScreen> {
  late final Stream<PaymentRequest> _stream;

  @override
  void initState() {
    super.initState();
    _stream = sl<PaymentRequestRepository>().watchById(widget.id);
  }

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: StreamBuilder<PaymentRequest>(
          stream: _stream,
          builder: (context, snapshot) {
            final data = snapshot.data;

            return data == null
                ? TransferProgress(onBack: () => context.pop())
                : RequestScreenContent(request: data);
          },
        ),
      );
}

class PaymentRequestStatusRoute extends GoRouteData {
  const PaymentRequestStatusRoute(this.id);

  final String id;

  static final GlobalKey<NavigatorState> $parentNavigatorKey =
      authenticatedNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      RequestPaymentStatusScreen(id: id);
}

class RequestScreenContent extends StatelessWidget {
  const RequestScreenContent({
    super.key,
    required this.request,
  });

  final PaymentRequest request;

  @override
  Widget build(BuildContext context) {
    // return data.state.when(
    //   initial: () => BlocProvider<PaymentRequestVerifierBloc>( //TODO initialize this
    //     create: (_) => sl<PaymentRequestVerifierBloc>(param1: data),
    //     lazy: false,
    //     child: BlocListener<PaymentRequestVerifierBloc,
    //         PaymentRequestVerifierState>(
    //       listener: (context, state) => state.whenOrNull(
    //         success: () => context.notifyBalanceAffected(), //TODO balance update also
    //       ),
    //     ),
    //   ),
    // );

    final tokenlist = sl<TokenList>();

    final amount = request.payRequest.cryptoAmount(tokenlist);

    final String? statusTitle = switch (request.state) {
      PaymentRequestCompleted() => context.l10n.transferSuccessTitle,
      PaymentRequestInitial() || PaymentRequestFailure() => null,
    };

    final String statusContent = switch (request.state) {
      PaymentRequestCompleted() => context.l10n.moneyReceived,
      PaymentRequestInitial() => context.l10n.requestPaymentPending,
      PaymentRequestFailure() =>
        context.l10n.paymentRequestFailureNotificationTitle(
          amount?.let((a) => a.format(context.locale)) ?? '-',
        ),
    };

    final resendButton = CpButton(
      size: CpButtonSize.big,
      width: double.infinity,
      text: context.l10n.resendLink,
      onPressed: () => SharePaymentRequestRoute(request.id).push<void>(context),
    );

    final cancelButton = Padding(
      padding: EdgeInsets.only(
        top: 24,
        bottom: MediaQuery.paddingOf(context).bottom + 16,
      ),
      child: CpTextButton(
        text: context.l10n.requestDeletePaymentTitle,
        variant: CpTextButtonVariant.light,
        onPressed: () => showConfirmationDialog(
          context,
          title: context.l10n.paymentRequest_lblCancelConfirmationTitle
              .toUpperCase(),
          message: context.l10n.paymentRequest_lblCancelConfirmationSubtitle,
          onConfirm: () {
            sl<PaymentRequestRepository>().delete(request.id);
            context.pop();
          },
        ),
      ),
    );

    final List<Widget> actions = switch (request.state) {
      PaymentRequestInitial() || PaymentRequestFailure() => [
          resendButton,
          cancelButton,
        ],
      PaymentRequestCompleted() => const [],
    };

    return StatusScreen(
      onBackButtonPressed: () => context.pop(),
      title: context.l10n.requestPaymentTitle.toUpperCase(),
      statusType: request.state.toStatusType(),
      statusTitle: statusTitle?.let(Text.new),
      statusContent: Text(statusContent),
      content: CpContentPadding(
        child: Column(
          children: [
            _Timeline(
              request: request,
              amount: amount,
            ),
            const Spacer(flex: 4),
            if (request.payRequest.invoice case final reference?)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: InvoiceTextWidget(reference: reference),
              ),
            ...actions,
          ],
        ),
      ),
    );
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.request,
    required this.amount,
  });

  final PaymentRequest request;
  final CryptoAmount? amount;

  @override
  Widget build(BuildContext context) {
    final CpTimelineStatus timelineStatus = request.state.toTimelineStatus();

    final requestCreated = CpTimelineItem(
      title: context.l10n.requestPaymentCreated,
      trailing: amount?.let((a) => a.format(context.locale)),
      subtitle: request.created.let((t) => context.formatDate(t)),
    );
    final moneyReceived = CpTimelineItem(
      title: context.l10n.requestPaymentReceived,
    );

    return CpTimeline(
      status: timelineStatus,
      items: [
        requestCreated,
        moneyReceived,
      ],
      active: request.state.toActiveItem(),
      animated: false,
    );
  }
}

extension on PaymentRequestState {
  CpStatusType toStatusType() => switch (this) {
        PaymentRequestInitial() => CpStatusType.info,
        PaymentRequestCompleted() => CpStatusType.success,
        PaymentRequestFailure() => CpStatusType.error,
      };

  CpTimelineStatus toTimelineStatus() => switch (this) {
        PaymentRequestInitial() => CpTimelineStatus.inProgress,
        PaymentRequestCompleted() => CpTimelineStatus.success,
        PaymentRequestFailure() => CpTimelineStatus.failure,
      };

  int toActiveItem() => switch (this) {
        PaymentRequestInitial() => 0,
        PaymentRequestCompleted() || PaymentRequestFailure() => 1,
      };
}

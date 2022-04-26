import 'package:cryptoplease/bl/activities/activity.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request.dart';
import 'package:cryptoplease/bl/payment_requests/payment_request_verifier/bloc.dart';
import 'package:cryptoplease/bl/payment_requests/repository.dart';
import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/screens/authenticated/outgoing_transfer_flow/outgoing_transfer_flow.dart';
import 'package:cryptoplease/presentation/screens/authenticated/receive_flow/link_details/flow.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class ActivityList extends StatelessWidget {
  const ActivityList({
    Key? key,
    required this.activities,
  }) : super(key: key);

  final IList<Activity> activities;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemBuilder: (context, i) => activities[i].map(
          outgoingTransfer: (n) => _SKOutgoingTile(transfer: n.transfer),
          splitKeyIncoming: (n) => _SKIncomingTile(activitiy: n),
          paymentRequest: (n) => PaymentRequestTile(id: n.id),
        ),
        itemCount: activities.length,
      );
}

class PaymentRequestTile extends StatefulWidget {
  const PaymentRequestTile({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<PaymentRequestTile> createState() => _PaymentRequestTileState();
}

class _PaymentRequestTileState extends State<PaymentRequestTile> {
  late Stream<PaymentRequest> _stream;

  @override
  void initState() {
    super.initState();
    _stream = context.read<PaymentRequestRepository>().watchById(widget.id);
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<PaymentRequest>(
        stream: _stream,
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data == null) {
            return ListTile(
              key: ValueKey(widget.id),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: CpColors.yellowColor,
                child: Assets.icons.incoming.svg(),
              ),
              title: const Text('', style: _titleStyle),
              subtitle: Text(
                context.l10n.paymentRequestNotificationSubtitle,
                style: _subtitleStyle,
              ),
            );
          }

          String title() {
            final formattedAmount =
                data.formattedAmount(DeviceLocale.localeOf(context));

            switch (data.state) {
              case PaymentRequestState.initial:
                return context.l10n.paymentRequestInitialNotificationTitle(
                  formattedAmount,
                  data.payerName,
                );
              case PaymentRequestState.completed:
                return context.l10n.paymentRequestSuccessNotificationTitle(
                  formattedAmount,
                  data.payerName,
                );
              case PaymentRequestState.error:
                return context.l10n.paymentRequestFailureNotificationTitle(
                  formattedAmount,
                  data.payerName,
                );
            }
          }

          return BlocProvider<PaymentRequestVerifierBloc>(
            key: ValueKey(widget.id),
            create: (context) => PaymentRequestVerifierBloc(
              request: data,
              solanaClient: context.read<SolanaClient>(),
              repository: context.read<PaymentRequestRepository>(),
            ),
            lazy: false,
            child: ListTile(
              onTap: () => context.navigateToPaymentRequest(data.id),
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: CpColors.yellowColor,
                child: Assets.icons.incoming.svg(),
              ),
              title: Text(title(), style: _titleStyle),
              subtitle: Text(
                context.l10n.paymentRequestNotificationSubtitle,
                style: _subtitleStyle,
              ),
            ),
          );
        },
      );
}

class _SKIncomingTile extends StatelessWidget {
  const _SKIncomingTile({
    Key? key,
    required this.activitiy,
  }) : super(key: key);

  final SplitKeyIncomingActivity activitiy;

  void _onTap(BuildContext context) {
    final event = SplitKeyIncomingPaymentEvent.firstPartAdded(
      firstPart: activitiy.firstPart,
    );
    context.read<SplitKeyIncomingPaymentBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    final title = context.l10n.splitKeyIncomingNotificationTitle;
    final subTitle = context.l10n.splitKeyIncomingNotificationSubtitle;

    return ListTile(
      onTap: () => _onTap(context),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: CpColors.yellowColor,
        child: Assets.icons.incoming.svg(),
      ),
      title: Text(title, style: _titleStyle),
      subtitle: Text(subTitle, style: _subtitleStyle),
    );
  }
}

class _SKOutgoingTile extends StatelessWidget {
  const _SKOutgoingTile({Key? key, required this.transfer}) : super(key: key);

  final OutgoingTransfer transfer;

  void _onTap(BuildContext context) =>
      context.navigateToOutgoingTransfer(transfer.id, autoSubmit: false);

  @override
  Widget build(BuildContext context) {
    final amount = transfer.tokenType == OutgoingTransferTokenType.fungibleToken
        ? transfer.toAmount().format(DeviceLocale.localeOf(context))
        : 'NFT';
    final title = transfer.state.map(
      draft: always(
        context.l10n.splitKeyOutgoingDraftNotificationTitle(amount),
      ),
      ready: always(context.l10n.splitKeyOutgoingSentNotificationTitle(amount)),
    );
    final subtitle = transfer.map(
      splitKey: always(context.l10n.splitKeyOutgoingNotificationSubtitle),
      direct: always(context.l10n.directOutgoingNotificationSubtitle),
    );

    return ListTile(
      onTap: () => _onTap(context),
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: CpColors.purple,
        child: Assets.icons.outgoing.svg(),
      ),
      title: Text(title, style: _titleStyle),
      subtitle: Text(subtitle, style: _subtitleStyle),
    );
  }
}

const _titleStyle = TextStyle(
  fontSize: 18,
  color: CpColors.primaryTextColor,
  fontWeight: FontWeight.w500,
);

const _subtitleStyle = TextStyle(
  fontSize: 13,
  color: CpColors.secondaryTextColor,
);

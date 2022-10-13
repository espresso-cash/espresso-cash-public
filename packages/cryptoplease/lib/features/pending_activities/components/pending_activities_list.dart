import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request_verifier/bloc.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_details/flow.dart';
import 'package:cryptoplease/features/pending_activities/pending_activities_repository.dart';
import 'package:cryptoplease/features/pending_activities/pending_activity.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana.dart';

class PendingActivitiesList extends StatefulWidget {
  const PendingActivitiesList({
    Key? key,
  }) : super(key: key);

  @override
  State<PendingActivitiesList> createState() => _PendingActivitiesListState();
}

class _PendingActivitiesListState extends State<PendingActivitiesList> {
  late final Stream<IList<PendingActivity>> _stream;

  @override
  void initState() {
    super.initState();

    _stream = context.read<PendingActivitiesRepository>().watchAll();
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<IList<PendingActivity>>(
        stream: _stream,
        initialData: const IListConst([]),
        builder: (context, snapshot) => ListView.builder(
          itemBuilder: (context, i) {
            final item = snapshot.data![i];

            return item.map(
              outgoingPaymentRequest: (p) => PaymentRequestTile(id: p.id),
              outgoingDirectPayment: (p) => ListTile(
                title: const Text('Direct payment', style: _titleStyle),
                subtitle: Text(p.created.toString(), style: _subtitleStyle),
                leading: CircleAvatar(
                  radius: 25,
                  child: Assets.icons.outgoing.svg(),
                ),
              ),
              outgoingSplitKeyPayment: (p) => ListTile(
                title: const Text('Sending via link', style: _titleStyle),
                subtitle: Text(p.created.toString(), style: _subtitleStyle),
                leading: CircleAvatar(
                  radius: 25,
                  child: Assets.icons.outgoing.svg(),
                ),
              ),
            );
          },
          itemCount: snapshot.data!.length,
        ),
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

            return data.state.when(
              initial: () =>
                  context.l10n.paymentRequestInitialNotificationTitle(
                formattedAmount,
                data.payerName,
              ),
              completed: (_) =>
                  context.l10n.paymentRequestSuccessNotificationTitle(
                formattedAmount,
                data.payerName,
              ),
              failure: () =>
                  context.l10n.paymentRequestFailureNotificationTitle(
                formattedAmount,
                data.payerName,
              ),
            );
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
                data.created.toString(),
                style: _subtitleStyle,
              ),
            ),
          );
        },
      );
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

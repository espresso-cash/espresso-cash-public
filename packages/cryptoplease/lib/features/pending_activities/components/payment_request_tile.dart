import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/presentation/format_date.dart';
import 'package:cryptoplease/di.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request.dart';
import 'package:cryptoplease/features/payment_request/bl/payment_request_verifier/bloc.dart';
import 'package:cryptoplease/features/payment_request/bl/repository.dart';
import 'package:cryptoplease/features/payment_request/presentation/link_details/flow.dart';
import 'package:cryptoplease/features/pending_activities/components/styles.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _stream = sl<PaymentRequestRepository>().watchById(widget.id);
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
                radius: 21,
                child: Assets.icons.incoming.svg(),
              ),
              title: const Text('', style: titleStyle),
              subtitle: Text(
                context.l10n.paymentRequestNotificationSubtitle,
                style: subtitleStyle,
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
                data.label,
              ),
              completed: (_) =>
                  context.l10n.paymentRequestSuccessNotificationTitle(
                formattedAmount,
                data.label,
              ),
              failure: () =>
                  context.l10n.paymentRequestFailureNotificationTitle(
                formattedAmount,
                data.label,
              ),
            );
          }

          return BlocProvider<PaymentRequestVerifierBloc>(
            key: ValueKey(widget.id),
            create: (_) => sl<PaymentRequestVerifierBloc>(param1: data),
            lazy: false,
            child: ListTile(
              onTap: () => context.navigateToPaymentRequest(data.id),
              leading: CircleAvatar(
                radius: 21,
                backgroundColor: CpColors.yellowColor,
                child: Assets.icons.incoming.svg(),
              ),
              title: Text(title(), style: titleStyle),
              subtitle: Text(
                context.formatDate(data.created),
                style: subtitleStyle,
              ),
            ),
          );
        },
      );
}

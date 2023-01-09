import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/colors.dart';
import '../../../payment_request/formatted_amount.dart';
import '../../../payment_request/models/payment_request.dart';
import '../../../payment_request/watch_payment_request.dart';
import '../../../payment_request/widgets/payment_request_verifier.dart';
import 'styles.dart';

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
    _stream = watchPaymentRequest(widget.id);
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

          return PaymentRequestVerifier(
            key: ValueKey(widget.id),
            paymentRequest: data,
            child: ListTile(
              onTap: () =>
                  context.navigateTo(LinkDetailsFlowRoute(id: data.id)),
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

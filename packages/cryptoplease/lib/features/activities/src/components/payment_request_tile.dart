import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../di.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/activity_tile.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../payment_request/module.dart';

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
            return ActivityTile(
              key: ValueKey(widget.id),
              icon: CircleAvatar(
                radius: 21,
                child: Assets.icons.incoming.svg(),
              ),
              title: '',
              subtitle: context.l10n.paymentRequestNotificationSubtitle,
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
            child: ActivityTile(
              icon: CircleAvatar(
                radius: 21,
                backgroundColor: CpColors.yellowColor,
                child: Assets.icons.incoming.svg(),
              ),
              title: title(),
              subtitle: context.formatDate(data.created),
              actions: [
                CpButton(
                  text: 'Remind me',
                  minWidth: 120,
                  size: CpButtonSize.micro,
                  onPressed: () =>
                      context.navigateTo(LinkDetailsFlowRoute(id: data.id)),
                ),
                CpButton(
                  text: 'Cancel',
                  minWidth: 120,
                  size: CpButtonSize.micro,
                  variant: CpButtonVariant.secondary,
                  onPressed: () => sl<PaymentRequestRepository>().delete(data),
                ),
              ],
            ),
          );
        },
      );
}

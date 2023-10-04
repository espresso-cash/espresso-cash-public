import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../outgoing_dln_payments/screens/details_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OutgoingDlnTile extends StatelessWidget {
  const OutgoingDlnTile({super.key, required this.activity});

  final OutgoingDlnPaymentActivity activity;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.sentDirectly,
        timestamp: context.formatDate(activity.created),
        icon: Assets.icons.paymentIcon.svg(),
        outgoingAmount: activity.data.payment.inputAmount
            .format(DeviceLocale.localeOf(context)),
        status: activity.data.status.map(
          txCreated: always(CpActivityTileStatus.inProgress),
          txSent: always(CpActivityTileStatus.inProgress),
          success: always(CpActivityTileStatus.inProgress),
          txFailure: always(CpActivityTileStatus.failure),
          fulfilled: always(CpActivityTileStatus.success),
          cancelled: always(CpActivityTileStatus.canceled),
        ),
        onTap: () => context.router
            .navigate(OutgoingDlnPaymentDetailsScreen.route(id: activity.id)),
      );
}

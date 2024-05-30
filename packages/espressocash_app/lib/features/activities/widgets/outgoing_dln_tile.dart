import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../outgoing_dln_payments/screens/details_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OutgoingDlnTile extends StatelessWidget {
  const OutgoingDlnTile({
    super.key,
    required this.activity,
    this.showIcon = true,
  });

  final OutgoingDlnPaymentActivity activity;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.sentDirectly,
        timestamp: context.formatDate(activity.created),
        icon: Assets.icons.paymentIcon.svg(),
        outgoingAmount: activity.data.payment.inputAmount
            .format(DeviceLocale.localeOf(context), maxDecimals: 2),
        status: activity.data.status.map(
          txCreated: always(CpActivityTileStatus.inProgress),
          txSent: always(CpActivityTileStatus.inProgress),
          success: always(CpActivityTileStatus.inProgress),
          txFailure: always(CpActivityTileStatus.failure),
          fulfilled: always(CpActivityTileStatus.success),
          unfulfilled: always(CpActivityTileStatus.failure),
        ),
        onTap: () =>
            OutgoingDlnPaymentDetailsScreen.push(context, id: activity.id),
        showIcon: showIcon,
      );
}

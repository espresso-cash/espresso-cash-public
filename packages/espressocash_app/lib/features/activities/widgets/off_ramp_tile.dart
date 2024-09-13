import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../ramp/screens/off_ramp_order_screen.dart';
import '../../ramp/widgets/off_ramp_order_details.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OffRampTile extends StatelessWidget {
  const OffRampTile({
    super.key,
    required this.activity,
    this.showIcon = true,
  });

  final OffRampActivity activity;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => OffRampOrderDetails(
        orderId: activity.id,
        builder: (context, order) => CpActivityTile(
          title: context.l10n.activities_lblWithdraw,
          incomingAmount: order?.receiveAmount?.format(
            context.locale,
            maxDecimals: 2,
          ),
          icon: Assets.icons.paymentIcon.svg(),
          status: switch (order?.status) {
            OffRampOrderStatus.completed => CpActivityTileStatus.success,
            OffRampOrderStatus.failure => CpActivityTileStatus.failure,
            OffRampOrderStatus.refunded => CpActivityTileStatus.canceled,
            // ignore: avoid-wildcard-cases-with-enums, check if needed
            _ => CpActivityTileStatus.inProgress,
          },
          timestamp: context.formatDate(activity.created),
          onTap: () => OffRampOrderScreen.push(context, id: activity.id),
          showIcon: showIcon,
        ),
      );
}

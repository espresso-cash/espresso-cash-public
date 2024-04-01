import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../utils/extensions.dart';
import '../../ramp/screens/on_ramp_order_screen.dart';
import '../../ramp/widgets/on_ramp_order_details.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OnRampTile extends StatelessWidget {
  const OnRampTile({super.key, required this.activity});

  final OnRampActivity activity;

  @override
  Widget build(BuildContext context) => OnRampOrderDetails(
        orderId: activity.id,
        builder: (context, order) => CpActivityTile(
          title: context.l10n.activities_lblAddCash,
          icon: Assets.icons.paymentIcon.svg(),
          status: switch (order?.status) {
            OnRampOrderStatus.depositExpired ||
            OnRampOrderStatus.failure =>
              CpActivityTileStatus.failure,
            OnRampOrderStatus.completed => CpActivityTileStatus.success,
            OnRampOrderStatus.waitingForDeposit ||
            OnRampOrderStatus.waitingForPartner ||
            null =>
              CpActivityTileStatus.inProgress,
          },
          timestamp: context.formatDate(activity.created),
          incomingAmount: order?.receiveAmount?.format(
            context.locale,
            maxDecimals: 2,
          ),
          onTap: () => OnRampOrderRoute(order?.id ?? '').go(context),
        ),
      );
}

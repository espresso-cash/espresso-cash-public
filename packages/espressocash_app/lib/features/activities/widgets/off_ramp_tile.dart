import 'package:espressocash_common/flutter.dart';
import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../utils/extensions.dart';
import '../../ramp/screens/off_ramp_order_screen.dart';
import '../../ramp/widgets/off_ramp_order_details.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OffRampTile extends StatelessWidget {
  const OffRampTile({super.key, required this.activity});

  final OffRampActivity activity;

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
          status: order?.status == OffRampOrderStatus.completed
              ? CpActivityTileStatus.success
              : order?.status == OffRampOrderStatus.failure
                  ? CpActivityTileStatus.failure
                  : CpActivityTileStatus.inProgress,
          timestamp: context.formatDate(activity.created),
          onTap: () => OffRampOrderRoute(activity.id).go(context),
        ),
      );
}

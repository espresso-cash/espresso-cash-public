import 'package:flutter/widgets.dart';

import '../../../core/presentation/format_date.dart';
import '../../../gen/assets.gen.dart';
import '../../ramp/kado/widgets/kado_on_ramp_order_details.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OnRampTile extends StatelessWidget {
  const OnRampTile({super.key, required this.activity});

  final OnRampActivity activity;

  @override
  Widget build(BuildContext context) => KadoOnRampOrderDetails(
        orderId: activity.id,
        builder: (context, order) => CpActivityTile(
          title: order?.humanStatus ?? '',
          icon: Assets.icons.paymentIcon.svg(),
          status: order?.isCompleted == true
              ? CpActivityTileStatus.success
              : CpActivityTileStatus.inProgress,
          timestamp: context.formatDate(activity.created),
        ),
      );
}

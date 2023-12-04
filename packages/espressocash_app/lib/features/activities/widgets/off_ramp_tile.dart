import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
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
          title: order?.amount.let(
                (amount) => context.l10n.activities_lblSoldToken(
                  amount.format(
                    context.locale,
                    maxDecimals: 2,
                    roundInteger: true,
                  ),
                ),
              ) ??
              '',
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
          onTap: () => context.router
              .push(OffRampOrderScreen.route(orderId: activity.id)),
        ),
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
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
          title: context.l10n.activities_lblBoughtToken(
            order?.amount?.let(
                  (amount) => amount.value != 0
                      ? amount.format(
                          context.locale,
                          maxDecimals: 2,
                          roundInteger: true,
                        )
                      : order.amount?.currency.symbol,
                ) ??
                '',
          ),
          icon: Assets.icons.paymentIcon.svg(),
          status: switch (order?.status) {
            OnRampOrderStatus.failure => CpActivityTileStatus.failure,
            OnRampOrderStatus.completed => CpActivityTileStatus.success,
            OnRampOrderStatus.waitingForPartner ||
            null =>
              CpActivityTileStatus.inProgress,
          },
          timestamp: context.formatDate(activity.created),
          incomingAmount: order?.receiveAmount?.format(
            context.locale,
            maxDecimals: 2,
          ),
          onTap: () => context.router
              .push(OnRampOrderScreen.route(orderId: order?.id ?? '')),
        ),
      );
}

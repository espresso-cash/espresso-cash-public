import 'package:dfunc/dfunc.dart';
import 'package:flutter/widgets.dart';

import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
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
          title: order?.amount?.let(
                (amount) => context.l10n.activities_lblBoughtToken(
                  amount.format(
                    context.locale,
                    maxDecimals: 2,
                    roundInteger: true,
                  ),
                ),
              ) ??
              '',
          icon: Assets.icons.paymentIcon.svg(),
          status: order?.isCompleted == true
              ? CpActivityTileStatus.success
              : CpActivityTileStatus.inProgress,
          timestamp: context.formatDate(activity.created),
          incomingAmount: order?.receiveAmount?.format(
            context.locale,
            maxDecimals: 2,
          ),
        ),
      );
}

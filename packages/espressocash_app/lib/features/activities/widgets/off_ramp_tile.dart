import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../ramp/screens/off_ramp_order_screen.dart';
import '../../ramp/services/off_ramp_order_service.dart';
import '../../ramp/widgets/off_ramp_order_details.dart';
import '../../ramp_partner/models/ramp_type.dart';
import '../models/activity.dart';
import 'activity_tile.dart';
import 'kyc_tile.dart';

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
        builder: (context, order) =>
            order?.status == OffRampOrderStatus.waitingUserVerification
                ? _KycTile(activity: activity, order: order)
                : _ActivityTile(
                    order: order,
                    activity: activity,
                    showIcon: showIcon,
                  ),
      );
}

class _KycTile extends StatelessWidget {
  const _KycTile({
    required this.activity,
    required this.order,
  });

  final OffRampActivity activity;
  final OffRampOrder? order;

  @override
  Widget build(BuildContext context) => KycTile(
        title: context.l10n.activities_lblWithdraw,
        timestamp: context.formatDate(activity.created),
        outgoingAmount: order?.amount.format(
          context.locale,
          maxDecimals: 2,
        ),
        preOrder: (
          preOrderId: activity.id,
          preAmount: order?.receiveAmount,
        ),
        rampType: RampType.offRamp,
      );
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.order,
    required this.showIcon,
  });

  final OffRampActivity activity;
  final OffRampOrder? order;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.activities_lblWithdraw,
        incomingAmount: order?.receiveAmount?.format(
          context.locale,
          maxDecimals: 2,
        ),
        icon: Assets.icons.paymentIcon.svg(),
        status: switch (order?.status) {
          OffRampOrderStatus.completed => CpActivityTileStatus.success,
          OffRampOrderStatus.failure ||
          OffRampOrderStatus.rejected =>
            CpActivityTileStatus.failure,
          OffRampOrderStatus.refunded => CpActivityTileStatus.canceled,
          // ignore: avoid-wildcard-cases-with-enums, check if needed
          _ => CpActivityTileStatus.inProgress,
        },
        timestamp: context.formatDate(activity.created),
        onTap: () => OffRampOrderScreen.push(context, id: activity.id),
        showIcon: showIcon,
      );
}

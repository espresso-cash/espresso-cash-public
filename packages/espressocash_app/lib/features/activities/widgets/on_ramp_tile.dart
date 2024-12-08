import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../ramp/screens/on_ramp_order_screen.dart';
import '../../ramp/widgets/on_ramp_order_details.dart';
import '../../ramp_partner/models/ramp_type.dart';
import '../models/activity.dart';
import 'activity_tile.dart';
import 'kyc_tile.dart';

class OnRampTile extends StatelessWidget {
  const OnRampTile({
    super.key,
    required this.activity,
    this.showIcon = true,
  });

  final OnRampActivity activity;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => OnRampOrderDetails(
        orderId: activity.id,
        builder: (context, order) =>
            order?.status == OnRampOrderStatus.waitingUserVerification
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

  final OnRampActivity activity;
  final OnRampOrder? order;

  @override
  Widget build(BuildContext context) => KycTile(
        title: context.l10n.activities_lblAddCash,
        timestamp: context.formatDate(activity.created),
        incomingAmount: order?.receiveAmount?.format(
          context.locale,
          maxDecimals: 2,
        ),
        preOrder: (
          preOrderId: activity.id,
          preAmount: order?.manualDeposit?.transferAmount,
        ),
        rampType: RampType.onRamp,
      );
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.order,
    required this.showIcon,
  });

  final OnRampActivity activity;
  final OnRampOrder? order;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.activities_lblAddCash,
        icon: Assets.icons.paymentIcon.svg(),
        status: switch (order?.status) {
          OnRampOrderStatus.depositExpired ||
          OnRampOrderStatus.failure ||
          OnRampOrderStatus.rejected =>
            CpActivityTileStatus.failure,
          OnRampOrderStatus.completed => CpActivityTileStatus.success,
          OnRampOrderStatus.waitingForDeposit ||
          OnRampOrderStatus.waitingUserVerification ||
          OnRampOrderStatus.waitingPartnerReview ||
          OnRampOrderStatus.waitingForPartner ||
          OnRampOrderStatus.pending ||
          OnRampOrderStatus.preProcessing ||
          OnRampOrderStatus.postProcessing ||
          OnRampOrderStatus.waitingForBridge ||
          null =>
            CpActivityTileStatus.inProgress,
        },
        timestamp: context.formatDate(activity.created),
        incomingAmount: order?.receiveAmount?.format(
          context.locale,
          maxDecimals: 2,
        ),
        onTap: () => OnRampOrderScreen.push(context, id: order?.id ?? ''),
        showIcon: showIcon,
      );
}

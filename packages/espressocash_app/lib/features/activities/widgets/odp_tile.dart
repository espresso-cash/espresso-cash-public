import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../outgoing_direct_payments/models/outgoing_direct_payment.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class ODPTile extends StatelessWidget {
  const ODPTile({super.key, required this.activity, this.showIcon = true});

  final ODPActivity activity;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => CpActivityTile(
    title: context.l10n.sentDirectly,
    timestamp: context.formatDate(activity.created),
    icon: Assets.icons.paymentIcon.svg(),
    outgoingAmount: activity.data.amount.format(DeviceLocale.localeOf(context)),
    status: switch (activity.data.status) {
      ODPStatusTxCreated() || ODPStatusTxSent() => CpActivityTileStatus.inProgress,
      ODPStatusSuccess() => CpActivityTileStatus.success,
      ODPStatusTxFailure() => CpActivityTileStatus.failure,
    },
    onTap: () => ODPDetailsScreen.push(context, id: activity.id),
    showIcon: showIcon,
  );
}

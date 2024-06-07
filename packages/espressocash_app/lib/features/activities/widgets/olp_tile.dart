import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../outgoing_link_payments/screens/olp_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OLPTile extends StatelessWidget {
  const OLPTile({
    super.key,
    required this.activity,
    this.showIcon = true,
  });

  final OLPActivity activity;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.sentViaLink,
        outgoingAmount:
            activity.data.amount.format(DeviceLocale.localeOf(context)),
        timestamp: context.formatDate(activity.created),
        icon: Assets.icons.paymentIcon.svg(),
        status: activity.data.status.maybeMap(
          withdrawn: always(CpActivityTileStatus.success),
          canceled: always(CpActivityTileStatus.canceled),
          txFailure: always(CpActivityTileStatus.failure),
          orElse: always(CpActivityTileStatus.inProgress),
        ),
        onTap: () => OLPScreen.push(context, id: activity.id),
        showIcon: showIcon,
      );
}

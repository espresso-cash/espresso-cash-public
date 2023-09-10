import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../ramp/ramp.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class ORPTile extends StatelessWidget {
  const ORPTile({super.key, required this.activity});

  final ORPActivity activity;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.activities_lblCashOutOngoing,
        timestamp: context.formatDate(activity.created),
        icon: Assets.icons.paymentIcon.svg(),
        outgoingAmount:
            activity.data.amount.format(DeviceLocale.localeOf(context)),
        status: switch (activity.data.status) {
          ORPStatusTxCreated() ||
          ORPStatusTxSent() ||
          ORPStatusSuccess() =>
            CpActivityTileStatus.inProgress,
          ORPStatusTxFailure() => CpActivityTileStatus.failure,
          ORPStatusWithdrawn() => CpActivityTileStatus.success,
        },
        onTap: () => context.router
            .navigate(OffRampDetailsScreen.route(id: activity.id)),
      );
}

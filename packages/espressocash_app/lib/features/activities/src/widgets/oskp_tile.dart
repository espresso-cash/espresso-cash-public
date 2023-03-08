import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/activity_tile.dart';
import '../../../balances/presentation/format_amount.dart';
import '../activity.dart';

class OSKPTile extends StatelessWidget {
  const OSKPTile({super.key, required this.activity});

  final OSKPActivity activity;

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
        onTap: () => context.router.navigate(OSKPRoute(id: activity.id)),
      );
}

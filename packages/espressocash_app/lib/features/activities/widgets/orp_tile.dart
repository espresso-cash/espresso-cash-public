import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../ramp/screens/off_ramp_details_screen.dart';
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
        status: activity.data.status.map(
          txCreated: always(CpActivityTileStatus.inProgress),
          txSent: always(CpActivityTileStatus.inProgress),
          success: always(CpActivityTileStatus.inProgress),
          txFailure: always(CpActivityTileStatus.failure),
          withdrawn: always(CpActivityTileStatus.success),
        ),
        onTap: () => context.router
            .navigate(OffRampDetailsScreen.route(id: activity.id)),
      );
}

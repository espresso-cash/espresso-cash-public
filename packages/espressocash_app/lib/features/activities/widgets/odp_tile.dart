import 'package:dfunc/dfunc.dart';
import 'package:espressocash_common/espressocash_common.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../utils/extensions.dart';
import '../../outgoing_direct_payments/screens/odp_details_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class ODPTile extends StatelessWidget {
  const ODPTile({super.key, required this.activity});

  final ODPActivity activity;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: context.l10n.sentDirectly,
        timestamp: context.formatDate(activity.created),
        icon: Assets.icons.paymentIcon.svg(),
        outgoingAmount: activity.data.amount.format(context.locale),
        status: activity.data.status.map(
          txCreated: always(CpActivityTileStatus.inProgress),
          txSent: always(CpActivityTileStatus.inProgress),
          success: always(CpActivityTileStatus.success),
          txFailure: always(CpActivityTileStatus.failure),
        ),
        onTap: () => ODPDetailsRoute(activity.id).go(context),
      );
}

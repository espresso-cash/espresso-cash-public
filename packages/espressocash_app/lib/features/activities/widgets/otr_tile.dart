import 'package:flutter/widgets.dart';

import '../../../data/db/db.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../routing.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../transaction_request/screens/otr_details_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class OtrTile extends StatelessWidget {
  const OtrTile({super.key, required this.activity});

  final TransactionRequestActivity activity;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: 'Payment to ${activity.data.label}',
        icon: Assets.icons.paymentIcon.svg(),
        status: switch (activity.data.status) {
          OTRStatus.created ||
          OTRStatus.sent =>
            CpActivityTileStatus.inProgress,
          OTRStatus.success => CpActivityTileStatus.success,
          OTRStatus.failure => CpActivityTileStatus.failure,
        },
        timestamp: context.formatDate(activity.created),
        outgoingAmount: activity.data.amount.format(
          context.locale,
          maxDecimals: 2,
        ),
        onTap: () => OTRDetailsRoute(activity.id).go(context),
      );
}

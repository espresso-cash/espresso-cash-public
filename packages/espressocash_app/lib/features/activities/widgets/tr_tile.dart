import 'package:flutter/widgets.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../../../utils/extensions.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../transaction_request/models/transaction_request.dart';
import '../../transaction_request/screens/tr_details_screen.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class TrTile extends StatelessWidget {
  const TrTile({
    super.key,
    required this.activity,
    this.showIcon = true,
  });

  final TransactionRequestActivity activity;
  final bool showIcon;

  @override
  Widget build(BuildContext context) => CpActivityTile(
        title: 'Payment to ${activity.data.label}',
        icon: Assets.icons.paymentIcon.svg(),
        status: switch (activity.data.status) {
          TRStatus.created || TRStatus.sent => CpActivityTileStatus.inProgress,
          TRStatus.success => CpActivityTileStatus.success,
          TRStatus.failure => CpActivityTileStatus.failure,
        },
        timestamp: context.formatDate(activity.created),
        outgoingAmount: activity.data.amount.format(
          context.locale,
          maxDecimals: 2,
        ),
        onTap: () => TRDetailsScreen.push(context, id: activity.id),
        showIcon: showIcon,
      );
}

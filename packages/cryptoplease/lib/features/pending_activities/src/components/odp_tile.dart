import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../routes.dart';
import '../pending_activity.dart';
import 'styles.dart';

class ODPTile extends StatelessWidget {
  const ODPTile({super.key, required this.activity});

  final ODPPendingActivity activity;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Sent directly',
                style: titleStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '-${activity.data.amount.format(DeviceLocale.localeOf(context))}',
              style: titleStyle,
            )
          ],
        ),
        subtitle: Text(
          context.formatDate(activity.created),
          style: subtitleStyle,
        ),
        leading: Assets.icons.outgoing.svg(),
        onTap: () => context.router.navigate(ODPDetailsRoute(id: activity.id)),
      );
}

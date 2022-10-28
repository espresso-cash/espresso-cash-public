import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app/routes.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/format_date.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/device_locale.dart';
import '../pending_activity.dart';
import 'styles.dart';

class OSKPTile extends StatelessWidget {
  const OSKPTile({super.key, required this.activity});

  final OSKPPendingActivity activity;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Sent via link',
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
        onTap: () => context.router.navigate(OSKPRoute(id: activity.id)),
      );
}

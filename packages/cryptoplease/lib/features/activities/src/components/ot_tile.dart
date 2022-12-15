import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../routes.gr.dart';
import '../activity.dart';
import 'styles.dart';

class OTTile extends StatelessWidget {
  const OTTile({super.key, required this.activity});

  final OTActivity activity;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: [
            const Expanded(
              child: Text(
                'Tip via QR Code',
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
        onTap: () => context.router.navigate(OutgoingTipRoute(id: activity.id)),
      );
}

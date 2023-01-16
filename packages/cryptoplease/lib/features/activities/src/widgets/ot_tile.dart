import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
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
            Expanded(
              child: Text(
                activity.data.status.maybeMap(
                  canceled: always(context.l10n.tipCanceled),
                  orElse: always(context.l10n.tipViaQrCode),
                ),
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
        onTap: () => context.router.navigate(OutgoingTipRoute(id: activity.id)),
        leading: activity.data.status.maybeMap(
          canceled: always(Assets.icons.txFailed.svg(width: iconSize)),
          orElse: always(Assets.icons.outgoing.svg(width: iconSize)),
        ),
      );
}

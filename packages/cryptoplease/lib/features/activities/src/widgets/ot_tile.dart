import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/activity_tile.dart';
import '../activity.dart';

class OTTile extends StatelessWidget {
  const OTTile({super.key, required this.activity});

  final OTActivity activity;

  @override
  Widget build(BuildContext context) => ActivityTile(
        title: context.l10n.tipViaQrcode,
        amount:
            '-${activity.data.amount.format(DeviceLocale.localeOf(context))}',
        subtitle: context.formatDate(activity.created),
        icon: Assets.icons.outgoing.svg(),
        onTap: () => context.router.navigate(OutgoingTipRoute(id: activity.id)),
      );
}

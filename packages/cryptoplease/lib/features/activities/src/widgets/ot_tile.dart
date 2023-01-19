import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
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
        title: activity.data.status.maybeMap(
          canceled: always(context.l10n.tipCanceled),
          orElse: always(context.l10n.tipViaQrCode),
        ),
        amount:
            '-${activity.data.amount.format(DeviceLocale.localeOf(context))}',
        subtitle: context.formatDate(activity.created),
        icon: activity.data.status.maybeMap(
          canceled: always(Assets.icons.txFailed.svg()),
          orElse: always(Assets.icons.outgoing.svg()),
        ),
        onTap: () => context.router.navigate(OutgoingTipRoute(id: activity.id)),
      );
}

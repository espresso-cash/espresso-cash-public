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
import '../../../../ui/button.dart';
import '../activity.dart';

class OSKPTile extends StatelessWidget {
  const OSKPTile({super.key, required this.activity});

  final OSKPActivity activity;

  @override
  Widget build(BuildContext context) => ActivityTile(
        title: activity.data.status.maybeMap(
          orElse: always(context.l10n.sentViaLink),
          canceled: always(context.l10n.transferCanceled),
        ),
        amount: activity.data.status.maybeMap(
          orElse: always(
            '-${activity.data.amount.format(DeviceLocale.localeOf(context))}',
          ),
          canceled: always(null),
        ),
        subtitle: context.formatDate(activity.created),
        icon: Assets.icons.outgoing.svg(),
        actions: [
          CpButton(
            text: context.l10n.view,
            size: CpButtonSize.micro,
            onPressed: () =>
                context.router.navigate(OSKPRoute(id: activity.id)),
          ),
        ],
      );
}

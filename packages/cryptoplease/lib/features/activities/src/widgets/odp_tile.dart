import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../core/presentation/utils.dart';
import '../../../../core/transactions/create_transaction_link.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/activity_tile.dart';
import '../activity.dart';

class ODPTile extends StatelessWidget {
  const ODPTile({super.key, required this.activity});

  final ODPActivity activity;

  @override
  Widget build(BuildContext context) => ActivityTile(
        title: context.l10n.sentDirectly,
        subtitle: context.formatDate(activity.created),
        icon: Assets.icons.outgoing.svg(),
        amount:
            '-${activity.data.amount.format(DeviceLocale.localeOf(context))}',
        onTap: () => activity.data.status.maybeWhen(
          success: (signature) {
            final link = Uri.parse(createTransactionLink(signature));
            context.openLink(link.toString());
          },
          orElse: () {
            context.router.navigate(ODPDetailsRoute(id: activity.id));
          },
        ),
      );
}

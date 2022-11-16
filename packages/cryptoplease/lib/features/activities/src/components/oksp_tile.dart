import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/button.dart';
import '../activity.dart';
import 'styles.dart';

class OSKPTile extends StatelessWidget {
  const OSKPTile({super.key, required this.activity});

  final OSKPActivity activity;

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
        subtitle: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              context.formatDate(activity.created),
              style: subtitleStyle,
            ),
            if (activity.isCancelable)
              CpButton(
                text: 'Cancel',
                size: CpButtonSize.micro,
                onPressed: () => context.router.push(
                  OSKPCancelRoute(payment: activity.data),
                ),
              )
          ],
        ),
        leading: Assets.icons.outgoing.svg(),
        onTap: () => context.router.navigate(OSKPRoute(id: activity.id)),
      );
}

// TODO(rhbrunetto): include cancel info on OSKPActivity (read from repo)
extension on OSKPActivity {
  bool get isCancelable => data.status.maybeMap(
        txCreated: T,
        txSent: T,
        txConfirmed: T,
        linksReady: T,
        txSendFailure: T,
        txWaitFailure: T,
        txLinksFailure: T,
        orElse: F,
      );
}

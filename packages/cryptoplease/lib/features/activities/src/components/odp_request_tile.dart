import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/activity_tile.dart';
import '../../../../ui/button.dart';
import '../../../outgoing_direct_payments/module.dart';
import '../activity.dart';

class ODPRequestTile extends StatelessWidget {
  const ODPRequestTile({super.key, required this.activity});

  final ODPRequestActivity activity;

  @override
  Widget build(BuildContext context) => ActivityTile(
        title: context.l10n.odpRequestTitle(
          activity.data.amount.format(DeviceLocale.localeOf(context)),
          activity.data.label ?? '',
        ),
        subtitle: context.formatDate(activity.created),
        icon: Assets.icons.outgoing.svg(),
        actions: [
          CpButton(
            text: context.l10n.pay,
            minWidth: 120,
            size: CpButtonSize.micro,
            onPressed: () => context.confirmODPRequest(activity.data),
          ),
          CpButton(
            text: context.l10n.decline,
            minWidth: 120,
            size: CpButtonSize.micro,
            variant: CpButtonVariant.secondary,
            onPressed: () => declineODPRequest(activity.data),
          ),
        ],
      );
}

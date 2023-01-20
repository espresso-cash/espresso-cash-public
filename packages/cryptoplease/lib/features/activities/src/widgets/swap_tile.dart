import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../core/tokens/token.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/activity_tile.dart';
import '../activity.dart';

class SwapTile extends StatelessWidget {
  const SwapTile({super.key, required this.activity});

  final SwapActivity activity;

  @override
  Widget build(BuildContext context) {
    final isBuyOperation = activity.data.seed.inputToken == Token.usdc;
    final token = isBuyOperation
        ? activity.data.seed.outputToken
        : activity.data.seed.inputToken;

    return ActivityTile(
      title: isBuyOperation
          ? context.l10n.boughtToken(token.name)
          : context.l10n.soldToken(token.name),
      amount:
          '-${activity.data.seed.amount.format(DeviceLocale.localeOf(context))}',
      subtitle: context.formatDate(activity.created),
      // TODO(rhbrunetto): improve icon
      icon: Assets.icons.outgoing.svg(),
      onTap: () => context.router.navigate(ProcessSwapRoute(id: activity.id)),
    );
  }
}

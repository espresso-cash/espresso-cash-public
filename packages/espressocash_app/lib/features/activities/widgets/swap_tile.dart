import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../core/presentation/format_date.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../../swap/screens/process_swap_screen.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
import '../models/activity.dart';
import 'activity_tile.dart';

class SwapTile extends StatelessWidget {
  const SwapTile({super.key, required this.activity});

  final SwapActivity activity;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final seed = activity.data.seed;
    final isBuyOperation = seed.inputToken == Token.usdc;
    final isInputMatch = seed.amount.cryptoCurrency.token == seed.inputToken;
    final targetToken = isBuyOperation ? seed.outputToken : seed.inputToken;

    final inAmount = seed.amount
        .let((it) => isInputMatch ? null : it)
        .maybeFlatMap((it) => it.format(locale));
    final outAmount = seed.amount
        .let((it) => isInputMatch ? it : null)
        .maybeFlatMap((it) => it.format(locale));

    return CpActivityTile(
      title: isBuyOperation
          ? context.l10n.activities_lblBoughtToken(targetToken.name)
          : context.l10n.soldToken(targetToken.name),
      incomingAmount: inAmount,
      outgoingAmount: outAmount,
      timestamp: context.formatDate(activity.created),
      icon: _SwapIcon(
        input: seed.inputToken,
        output: seed.outputToken,
      ),
      status: activity.data.status.map(
        txCreated: always(CpActivityTileStatus.inProgress),
        txSent: always(CpActivityTileStatus.inProgress),
        success: always(CpActivityTileStatus.success),
        txFailure: always(CpActivityTileStatus.failure),
      ),
      onTap: () =>
          context.router.navigate(ProcessSwapScreen.route(id: activity.id)),
    );
  }
}

class _SwapIcon extends StatelessWidget {
  const _SwapIcon({
    required this.input,
    required this.output,
  });

  final Token input;
  final Token output;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 42,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: TokenIcon(token: input, size: 30),
            ),
            const Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                maxRadius: 16,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: TokenIcon(token: output, size: 30),
            ),
          ],
        ),
      );
}

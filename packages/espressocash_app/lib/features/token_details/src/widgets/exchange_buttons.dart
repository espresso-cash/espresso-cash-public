import 'package:flutter/material.dart';

import '../../../../core/tokens/token.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../swap/widgets/extensions.dart';

class ExchangeButtons extends StatelessWidget {
  const ExchangeButtons({
    super.key,
    required this.token,
  });

  final Token token;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: CpButton(
                text: context.l10n.buy,
                width: double.infinity,
                onPressed: () => context.navigateToBuyToken(token),
              ),
            ),
            const SizedBox(width: 24),
            Flexible(
              child: CpButton(
                width: double.infinity,
                text: context.l10n.sell,
                onPressed: () => context.navigateToSellToken(token),
              ),
            ),
          ],
        ),
      );
}

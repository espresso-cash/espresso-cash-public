import 'package:flutter/material.dart';

import '../../../../core/tokens/token.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../swap/module.dart';

class ExchangeButtons extends StatelessWidget {
  const ExchangeButtons({
    Key? key,
    required this.token,
  }) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CpButton(
            text: context.l10n.buy,
            onPressed: () => context.navigateToBuyToken(token),
          ),
          CpButton(
            text: context.l10n.sell,
            onPressed: () => context.navigateToSellToken(token),
          ),
        ],
      );
}

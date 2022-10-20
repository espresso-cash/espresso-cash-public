import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/status_screen.dart';
import 'package:cryptoplease/ui/status_widget.dart';
import 'package:flutter/material.dart';

class SwapSuccess extends StatelessWidget {
  const SwapSuccess({
    super.key,
    required this.swapOperation,
  });

  final SwapOperation swapOperation;

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.swapTitle,
        statusTitle: Text(context.l10n.splitKeySuccessMessage1),
        statusContent: Text(swapOperation.text(context)),
        statusType: CpStatusType.success,
        backgroundImage:
            Assets.icons.logoBgGreen.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 160),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.ok,
                onPressed: () => context.router.pop(),
              )
            ],
          ),
        ),
      );
}

extension on SwapOperation {
  String text(BuildContext context) {
    switch (this) {
      case SwapOperation.buy:
        return context.l10n.swapBuySuccess;
      case SwapOperation.sell:
        return context.l10n.swapSellSuccess;
    }
  }
}

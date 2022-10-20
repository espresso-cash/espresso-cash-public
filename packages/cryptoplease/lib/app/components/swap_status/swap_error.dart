import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/features/swap/bl/create_swap/bloc.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/status_screen.dart';
import 'package:cryptoplease/ui/status_widget.dart';
import 'package:flutter/material.dart';

class SwapError extends StatelessWidget {
  const SwapError({
    super.key,
    required this.operation,
    required this.onRetry,
  });

  final VoidCallback onRetry;
  final SwapOperation operation;

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.swapTitle,
        statusTitle: Text(context.l10n.splitKeyErrorMessage1),
        onBackButtonPressed: () => context.router.pop(),
        statusContent: Text(
          '${operation.text(context)} ${context.l10n.splitKeyErrorRetry}',
        ),
        statusType: CpStatusType.error,
        backgroundImage:
            Assets.icons.logoBgRed.svg(alignment: Alignment.bottomCenter),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 140),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.retry,
                onPressed: onRetry,
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
        return context.l10n.swapBuyFail;
      case SwapOperation.sell:
        return context.l10n.swapSellFail;
    }
  }
}

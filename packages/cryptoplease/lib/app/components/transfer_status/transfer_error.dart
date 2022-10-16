import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/ui/button.dart';
import 'package:cryptoplease/app/ui/status_screen.dart';
import 'package:cryptoplease/app/ui/status_widget.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class TransferError extends StatelessWidget {
  const TransferError({
    super.key,
    required this.onRetry,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusTitle: Text(context.l10n.splitKeyErrorMessage1),
        onBackButtonPressed: () => context.router.pop(),
        statusContent: Text(
          '${context.l10n.splitKeyErrorMessage2} ${context.l10n.splitKeyErrorRetry}',
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

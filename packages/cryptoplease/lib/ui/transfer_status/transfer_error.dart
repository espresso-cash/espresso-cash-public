import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/button.dart';
import 'package:cryptoplease/ui/status_screen.dart';
import 'package:cryptoplease/ui/status_widget.dart';
import 'package:flutter/material.dart';

class TransferError extends StatelessWidget {
  const TransferError({
    super.key,
    required this.onRetry,
    required this.onBack,
  });

  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusTitle: Text(context.l10n.splitKeyErrorMessage1),
        onBackButtonPressed: onBack,
        statusContent: Text(
          '${context.l10n.splitKeyErrorMessage2} ${context.l10n.splitKeyErrorRetry}',
        ),
        statusType: CpStatusType.error,
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

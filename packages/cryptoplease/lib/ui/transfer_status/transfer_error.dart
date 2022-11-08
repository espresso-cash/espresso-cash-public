import 'package:flutter/material.dart';

import '../../core/transactions/tx_sender.dart';
import '../../l10n/l10n.dart';
import '../button.dart';
import '../status_screen.dart';
import '../status_widget.dart';

class TransferError extends StatelessWidget {
  const TransferError({
    super.key,
    required this.onRetry,
    required this.onBack,
    this.reason,
  });

  final VoidCallback onRetry;
  final VoidCallback onBack;
  final TxFailureReason? reason;

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusTitle: Text(context.l10n.splitKeyErrorMessage1),
        onBackButtonPressed: onBack,
        statusContent: Text(
          [
            context.l10n.splitKeyErrorMessage2,
            if (reason == TxFailureReason.insufficientFunds)
              context.l10n.errorMessageInsufficientFunds
            else
              context.l10n.splitKeyErrorRetry,
          ].join(' '),
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

import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';
import '../models/tx_results.dart';

class TransferError extends StatelessWidget {
  const TransferError({
    super.key,
    required this.onRetry,
    required this.onBack,
    this.reason,
    this.onCancel,
  });

  final VoidCallback onRetry;
  final VoidCallback onBack;
  final VoidCallback? onCancel;
  final TxFailureReason? reason;

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusTitle: Text(context.l10n.transferErrorTitle),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.retry,
                onPressed: onRetry,
              ),
              if (onCancel != null)
                _CancelButton(
                  onCancel: onCancel,
                ),
              const SizedBox(height: 140),
              SizedBox(height: MediaQuery.paddingOf(context).bottom),
            ],
          ),
        ),
      );
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({required this.onCancel});

  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CpTextButton(
          text: context.l10n.cancelTransferBtn,
          variant: CpTextButtonVariant.light,
          onPressed: onCancel,
        ),
      );
}

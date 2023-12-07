import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../transactions/models/tx_results.dart';

class TransferError extends StatelessWidget {
  const TransferError({
    super.key,
    required this.onBack,
    this.reason,
  });

  final VoidCallback onBack;
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
              context.l10n.errorMessageInsufficientFunds,
          ].join(' '),
        ),
        statusType: CpStatusType.error,
      );
}

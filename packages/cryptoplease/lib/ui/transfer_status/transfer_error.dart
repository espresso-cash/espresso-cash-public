import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../button.dart';
import '../status_screen.dart';
import '../status_widget.dart';

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

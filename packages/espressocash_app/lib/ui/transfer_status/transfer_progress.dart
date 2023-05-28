import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../colors.dart';
import '../status_screen.dart';
import '../status_widget.dart';

class TransferProgress extends StatelessWidget {
  const TransferProgress({
    super.key,
    required this.onBack,
  });

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) => StatusScreen(
        onBackButtonPressed: onBack,
        title: context.l10n.splitKeyTransferTitle,
        statusContent: Text(context.l10n.splitKeyTransactionLoading),
        statusType: CpStatusType.info,
        content: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: CircularProgressIndicator(
                  color: CpColors.yellowColor,
                  strokeWidth: 8,
                ),
              ),
            ],
          ),
        ),
      );
}

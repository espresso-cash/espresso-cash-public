import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/status_screen.dart';
import 'package:cryptoplease/ui/status_widget.dart';
import 'package:flutter/material.dart';

class TransferProgress extends StatelessWidget {
  const TransferProgress({super.key});

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusContent: Text(context.l10n.splitKeyTransactionLoading),
        statusType: CpStatusType.info,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: const [
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

import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/status_screen.dart';
import '../../../../ui/status_widget.dart';

class InvalidEscrowErrorWidget extends StatelessWidget {
  const InvalidEscrowErrorWidget({super.key});

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusTitle: Text(context.l10n.transferErrorTitle),
        statusContent: Text(
          context.l10n.invalidEscrowError,
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
                text: context.l10n.ok,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
}

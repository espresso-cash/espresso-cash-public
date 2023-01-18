import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';
import '../button.dart';
import '../status_screen.dart';
import '../status_widget.dart';
import '../text_button.dart';

class TransferSuccess extends StatelessWidget {
  const TransferSuccess({
    super.key,
    required this.onOkPressed,
    required this.onMoreDetails,
    required this.content,
  });

  final VoidCallback onOkPressed;
  final VoidCallback onMoreDetails;
  final String content;

  @override
  Widget build(BuildContext context) => StatusScreen(
        title: context.l10n.splitKeyTransferTitle,
        statusTitle: Text(context.l10n.transferSuccessTitle),
        statusContent: Text(content),
        statusType: CpStatusType.success,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              CpTextButton(
                variant: CpTextButtonVariant.inverted,
                text: context.l10n.moreDetails,
                onPressed: onMoreDetails,
              ),
              const SizedBox(height: 160),
              CpButton(
                size: CpButtonSize.big,
                width: double.infinity,
                text: context.l10n.ok,
                onPressed: onOkPressed,
              )
            ],
          ),
        ),
      );
}

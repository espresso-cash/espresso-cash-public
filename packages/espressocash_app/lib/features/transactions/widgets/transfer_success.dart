import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/status_screen.dart';
import '../../../ui/status_widget.dart';
import '../../../ui/text_button.dart';

class TransferSuccess extends StatelessWidget {
  const TransferSuccess({
    super.key,
    required this.onOkPressed,
    required this.statusContent,
    required this.onBack,
    this.content,
    this.onMoreDetailsPressed,
  });

  final VoidCallback onOkPressed;
  final String statusContent;
  final Widget? content;
  final VoidCallback? onMoreDetailsPressed;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final content = this.content;

    return StatusScreen(
      onBackButtonPressed: onBack,
      title: context.l10n.splitKeyTransferTitle,
      statusTitle: Text(context.l10n.transferSuccessTitle),
      statusContent: Text(statusContent),
      statusType: CpStatusType.success,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            if (content != null) content else const Spacer(),
            CpButton(
              size: CpButtonSize.big,
              width: double.infinity,
              text: context.l10n.ok,
              onPressed: onOkPressed,
            ),
            if (onMoreDetailsPressed != null)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CpTextButton(
                  variant: CpTextButtonVariant.light,
                  text: context.l10n.moreDetails,
                  onPressed: onMoreDetailsPressed,
                ),
              ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

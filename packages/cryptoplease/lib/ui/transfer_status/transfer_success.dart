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
    required this.statusContent,
    this.content,
    this.onMoreDetaisPressed,
  });

  final VoidCallback onOkPressed;
  final String statusContent;
  final Widget? content;
  final VoidCallback? onMoreDetaisPressed;

  @override
  Widget build(BuildContext context) {
    final content = this.content;

    return StatusScreen(
      title: context.l10n.splitKeyTransferTitle,
      statusTitle: Text(context.l10n.transferSuccessTitle),
      statusContent: Text(statusContent),
      statusType: CpStatusType.success,
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 24),
            if (content != null) content,
            const Spacer(),
            CpButton(
              size: CpButtonSize.big,
              width: double.infinity,
              text: context.l10n.ok,
              onPressed: onOkPressed,
            ),
            if (onMoreDetaisPressed != null)
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: CpTextButton(
                  variant: CpTextButtonVariant.inverted,
                  text: context.l10n.moreDetails,
                  onPressed: onMoreDetaisPressed,
                ),
              ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

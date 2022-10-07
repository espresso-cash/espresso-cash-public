import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

void showCancelDialog(
  BuildContext context, {
  required VoidCallback onCancelPressed,
}) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => CpTheme.light(
      child: AlertDialog(
        content: Text(
          context.l10n.transferCancelConfirmationDialogContent,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: CpColors.secondaryTextColor,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                (_) => CpColors.secondaryTextColor,
              ),
            ),
            child: Text(context.l10n.no),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancelPressed.call();
            },
            child: Text(context.l10n.yes),
          ),
        ],
      ),
    ),
  );
}

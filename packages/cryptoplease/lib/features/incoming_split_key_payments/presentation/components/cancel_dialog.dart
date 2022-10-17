import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/theme.dart';
import 'package:flutter/material.dart';

void showCancelDialog(BuildContext context, VoidCallback onCancel) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => CpTheme.light(
      child: AlertDialog(
        content: Text(
          context.l10n.splitKeyConfirmationDialogContent,
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
              context.router.pop();
              onCancel();
            },
            child: Text(context.l10n.yes),
          ),
        ],
      ),
    ),
  );
}

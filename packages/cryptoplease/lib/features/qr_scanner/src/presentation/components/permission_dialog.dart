import 'package:flutter/material.dart';

import '../../../../../l10n/l10n.dart';

void showPermissionDialog(
  BuildContext context,
  VoidCallback onManualInput,
) =>
    showDialog<void>(
      context: context,
      builder: (context) => Theme(
        data: ThemeData.light(),
        child: AlertDialog(
          title: Text(context.l10n.qrPermissionDialogTitle),
          content: Text(context.l10n.qrPermissionDialogMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onManualInput();
              },
              child: Text(context.l10n.qrInputAddressButton),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.ok),
            ),
          ],
        ),
      ),
    );

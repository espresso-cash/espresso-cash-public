import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String title, Exception e) =>
    showDialog<void>(
      context: context,
      builder: (context) => Theme(
        data: ThemeData.light(),
        child: AlertDialog(
          title: Text(title),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );

Future<void> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  required void Function() onConfirm,
}) =>
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: ThemeData.light(),
        child: AlertDialog(
          title: Text(title),
          content: Text(message, style: _contentStyle),
          actions: [
            TextButton(
              style: _cancelButtonStyle,
              child: Text(context.l10n.cancel),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              style: _confirmButtonStyle,
              child: Text(context.l10n.ok),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
            ),
          ],
        ),
      ),
    );

Future<void> showWarningDialog(
  BuildContext context, {
  required String title,
  required String message,
}) =>
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: ThemeData.light(),
        child: AlertDialog(
          title: Text(title),
          content: Text(message, style: _contentStyle),
          actions: <Widget>[
            TextButton(
              style: _confirmButtonStyle,
              child: Text(context.l10n.ok),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );

const _contentStyle = TextStyle(
  color: CpColors.primaryTextColor,
  fontWeight: FontWeight.normal,
  fontSize: 16,
);

final _cancelButtonStyle = TextButton.styleFrom(
  primary: CpColors.primaryTextColor,
);

final _confirmButtonStyle = TextButton.styleFrom(
  primary: CpColors.primaryColor,
);

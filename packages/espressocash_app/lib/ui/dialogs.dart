import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import 'button.dart';
import 'colors.dart';
import 'theme.dart';

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
    showModalBottomSheet(
      context: context,
      backgroundColor: CpColors.primaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(44),
          topRight: Radius.circular(44),
        ),
      ),
      builder: (context) => CpTheme.dark(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(64, 40, 64, 64),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title.toUpperCase(), style: _titleStyle),
              const SizedBox(height: 24),
              Text(message, style: _messageStyle, textAlign: TextAlign.center),
              const SizedBox(height: 32),
              CpButton(
                text: context.l10n.yesDeleteMyWallet,
                width: double.infinity,
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
              ),
              const SizedBox(height: 16),
              CpButton(
                text: context.l10n.no,
                width: double.infinity,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
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

final _confirmButtonStyle = TextButton.styleFrom(
  foregroundColor: CpColors.primaryColor,
);

const _titleStyle = TextStyle(
  fontSize: 17,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const _messageStyle = TextStyle(
  fontSize: 19,
  color: Colors.white,
  fontWeight: FontWeight.w500,
);

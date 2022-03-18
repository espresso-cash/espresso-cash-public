import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

void showClipboardSnackbar(BuildContext context) => showCustomSnackbar(
      context,
      message: context.l10n.copiedToClipboard,
      icon: const Icon(Icons.check, color: Colors.green),
    );

void showErrorSnackbar(BuildContext context, {required String message}) =>
    showCustomSnackbar(
      context,
      message: message,
      icon: const Icon(Icons.error, color: Colors.red),
    );

void showCustomSnackbar(
  BuildContext context, {
  required String message,
  Widget? icon,
}) {
  final snackbar = SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: const StadiumBorder(),
    content: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (icon != null)
            Container(
              height: 24,
              margin: const EdgeInsets.only(right: 16),
              child: icon,
            ),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

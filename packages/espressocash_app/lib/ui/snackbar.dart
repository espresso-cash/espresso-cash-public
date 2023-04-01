import 'package:flutter/material.dart';

import '../l10n/l10n.dart';

void showCpSnackbar(
  BuildContext context, {
  required String message,
  Widget? icon,
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
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

  (scaffoldMessengerKey?.currentState ?? ScaffoldMessenger.of(context))
      .showSnackBar(snackbar);
}

void showCpErrorSnackbar(
  BuildContext context, {
  required String message,
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
}) =>
    showCpSnackbar(
      context,
      message: message,
      icon: const Icon(Icons.error, color: Colors.red),
      scaffoldMessengerKey: scaffoldMessengerKey,
    );

void showClipboardSnackbar(BuildContext context) => showCpSnackbar(
      context,
      message: context.l10n.copiedToClipboard,
      icon: const Icon(Icons.check, color: Colors.green),
    );

import 'package:flutter/material.dart';

void showCpSnackbar(
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

void showCpErrorSnackbar(BuildContext context, {required String message}) =>
    showCpSnackbar(
      context,
      message: message,
      icon: const Icon(Icons.error, color: Colors.red),
    );

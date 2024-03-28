import 'package:flutter/material.dart';

import 'button.dart';

Future<void> showWarningDialog(
  BuildContext context, {
  required String title,
  required String message,
}) =>
    showDialog(
      context: context,
      barrierColor: _barrierColor,
      builder: (context) => Dialog(
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44),
            bottomLeft: Radius.circular(44),
            bottomRight: Radius.circular(44),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  height: 1.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              CpButton(
                text: 'OK',
                width: 170,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );

final _barrierColor = Colors.black.withOpacity(0.75);

import 'package:flutter/material.dart';

void showSnackBar(bool success, BuildContext context) {
  final snackbar = SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: const StadiumBorder(),
    backgroundColor: success ? Colors.green : Colors.red,
    content: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              success ? 'Succeeded' : 'Failed',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

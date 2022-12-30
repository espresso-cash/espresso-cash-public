import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  Either<Exception, String> result,
) {
  final message = result.fold(always('Action Failed'), identity);

  final snackbar = SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: result.fold(always(Colors.red), always(Colors.green)),
    content: ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
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

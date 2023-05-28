import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) =>
    showSnackBar(context, Either.left(_ErrorMessage(message)));

void showSnackBar(
  BuildContext context,
  Either<Exception, String> result,
) {
  final message = result.fold(
    (e) => e is _ErrorMessage ? e.message : 'Action Failed',
    identity,
  );

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

class _ErrorMessage implements Exception {
  const _ErrorMessage(this.message);

  final String message;
}

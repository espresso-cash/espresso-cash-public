import 'package:cryptoplease/bl/swap_tokens/swap_exception.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

void showSwapErrorDialog(
  BuildContext context,
  String title,
  SwapFailReason reason,
) =>
    showDialog<void>(
      context: context,
      builder: (context) => Theme(
        data: ThemeData.light(),
        child: AlertDialog(
          title: Text(title),
          content: Text(reason.buildMessage(context)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.ok),
            ),
          ],
        ),
      ),
    );

extension SwapFailExtension on SwapFailReason {
  String buildMessage(BuildContext context) {
    switch (this) {
      case SwapFailReason.routeNotFound:
        return context.l10n.swapFailRouteNotFound;
      case SwapFailReason.setupFailed:
        return context.l10n.swapFailSetupFailed;
      case SwapFailReason.swapFailed:
        return context.l10n.swapFailSwapFailed;
      case SwapFailReason.cleanUpFailed:
        return context.l10n.swapFailCleanUpFailed;
      case SwapFailReason.unknown:
        return context.l10n.swapFailUnknown;
      case SwapFailReason.insufficientBalance:
        // TODO(KB): Handle this case.
        return context.l10n.swapFailUnknown;
      case SwapFailReason.insufficientFee:
        // TODO(KB): Handle this case.
        return context.l10n.swapFailUnknown;
    }
  }
}

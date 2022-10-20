import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/features/swap/bl/swap_exception.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

void showSwapExceptionDialog(
  BuildContext context,
  String title,
  SwapException exception,
) =>
    showDialog<void>(
      context: context,
      builder: (context) => Theme(
        data: ThemeData.light(),
        child: AlertDialog(
          title: Text(title),
          content: Text(exception.description(context)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.ok),
            ),
          ],
        ),
      ),
    );

extension SwapExceptionExt on SwapException {
  String description(BuildContext context) => this.map(
        routeNotFound: always(context.l10n.swapFailRouteNotFound),
        setupFailed: always(context.l10n.swapFailSetupFailed),
        swapFailed: always(context.l10n.swapFailUnknown),
        cleanupFailed: always(context.l10n.swapFailCleanUpFailed),
        insufficientBalance: (e) => context.l10n.insufficientFundsMessage(
          e.amount.format(DeviceLocale.localeOf(context)),
          e.balance.format(DeviceLocale.localeOf(context)),
        ),
        insufficientFee: (e) => context.l10n.insufficientFundsForFeeMessage(
          e.fee.currency.symbol,
          e.fee.format(DeviceLocale.localeOf(context)),
        ),
        other: always(context.l10n.swapFailUnknown),
      );
}

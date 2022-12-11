import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../core/presentation/format_amount.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../l10n/l10n.dart';
import '../create_swap/bloc.dart';

void showSwapExceptionDialog(
  BuildContext context,
  String title,
  CreateSwapException exception,
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

extension SwapExceptionExt on CreateSwapException {
  String description(BuildContext context) => this.map(
        routeNotFound: always(context.l10n.swapFailRouteNotFound),
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

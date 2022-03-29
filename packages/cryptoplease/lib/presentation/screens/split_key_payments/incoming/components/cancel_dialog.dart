import 'package:cryptoplease/bl/split_key_payments/incoming/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showCancelDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) => CpTheme.light(
      child: AlertDialog(
        content: Text(
          context.l10n.splitKeyConfirmationDialogContent,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: CpColors.secondaryTextColor,
              ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                (_) => CpColors.secondaryTextColor,
              ),
            ),
            child: Text(context.l10n.no),
          ),
          TextButton(
            onPressed: () => _onAbortPressed(context),
            child: Text(context.l10n.yes),
          ),
        ],
      ),
    ),
  );
}

void _onAbortPressed(BuildContext context) {
  Navigator.of(context).pop();
  context
      .read<SplitKeyIncomingPaymentBloc>()
      .add(const SplitKeyIncomingPaymentEvent.cleared());
}

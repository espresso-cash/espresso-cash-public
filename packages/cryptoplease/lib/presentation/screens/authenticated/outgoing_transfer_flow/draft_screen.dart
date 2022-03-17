import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_transfers_bloc/bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/components/decorated_window.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DraftScreen extends StatelessWidget {
  const DraftScreen({
    Key? key,
    required this.transfer,
  }) : super(key: key);

  final OutgoingTransfer? transfer;

  @override
  Widget build(BuildContext context) {
    final transfer = this.transfer;

    final error = transfer == null
        ? null
        : context.select<OutgoingTransfersBloc, Exception?>(
            (b) => b.state.errors[transfer.id],
          );

    return CpLoader(
      isLoading: context
          .watch<OutgoingTransfersBloc>()
          .state
          .processingIds
          .contains(transfer?.id),
      child: DecoratedWindow(
        hasAppBarBorder: false,
        isScrollable: false,
        hasLogo: false,
        backgroundStyle: BackgroundStyle.light,
        nextButton: CpButton(
          onPressed: transfer == null
              ? null
              : () {
                  final event = OutgoingTransfersEvent.submitted(transfer.id);
                  context.read<OutgoingTransfersBloc>().add(event);
                },
          text: error == null ? context.l10n.next : context.l10n.retry,
        ),
        child: error == null
            ? Container()
            : CpContentPadding(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: kToolbarHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.l10n.transactionFailed.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 21, color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        error.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: CpTheme.of(context).secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

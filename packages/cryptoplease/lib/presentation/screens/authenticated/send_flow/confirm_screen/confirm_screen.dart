import 'package:cryptoplease/bl/outgoing_transfers/create_outgoing_transfer_bloc/bloc.dart';
import 'package:cryptoplease/bl/outgoing_transfers/outgoing_payment.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/presentation/dialogs.dart';
import 'package:cryptoplease/presentation/format_amount.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/confirm_screen/components/create_link_content.dart';
import 'package:cryptoplease/presentation/screens/authenticated/send_flow/confirm_screen/components/send_to_solana_address_content.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  void _onSubmitted() {
    context.read<CreateOutgoingTransferBloc>().add(
          const CreateOutgoingTransferEvent.submitted(
            OutgoingTransferTokenType.fungibleToken,
          ),
        );
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<CreateOutgoingTransferBloc, CreateOutgoingTransferState>(
        listenWhen: (s1, s2) => s1.flow != s2.flow,
        listener: (context, state) => state.flow.maybeMap(
          failure: (s) => showErrorDialog(
            context,
            'Failed to send money',
            s.error,
          ),
          orElse: ignore,
        ),
        builder: (context, state) {
          final locale = DeviceLocale.localeOf(context);
          final tokenAmount = state.tokenAmount.format(locale);
          final fiatAmount = state.fiatAmount.format(locale);
          final formattedFee = state.fee.format(DeviceLocale.localeOf(context));

          final String nextButtonText;
          switch (state.transferType) {
            case OutgoingTransferType.splitKey:
              nextButtonText = context.l10n.create;
              break;
            case OutgoingTransferType.direct:
              nextButtonText = context.l10n.send;
              break;
          }

          final Widget content;
          switch (state.transferType) {
            case OutgoingTransferType.splitKey:
              content = CreateLinkContent(
                amount: tokenAmount,
                fiatAmount: fiatAmount,
                fee: formattedFee,
              );
              break;
            case OutgoingTransferType.direct:
              content = SendToSolanaAddressContent(
                amount: tokenAmount,
                fiatAmount: fiatAmount,
                fee: formattedFee,
                address: state.recipientAddress ?? '',
              );
              break;
          }

          return CpLoader(
            isLoading: state.flow.isProcessing(),
            child: Scaffold(
              appBar: CpAppBar(
                hasBorder: false,
                nextButton: CpButton(
                  onPressed: _onSubmitted,
                  text: nextButtonText,
                ),
              ),
              body: CpContentPadding(child: content),
            ),
          );
        },
      );
}

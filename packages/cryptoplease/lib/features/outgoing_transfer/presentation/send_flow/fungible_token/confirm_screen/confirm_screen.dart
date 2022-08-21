import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/send_token_to_solana_address_content.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/token_create_link_content.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FtConfirmScreen extends StatefulWidget {
  const FtConfirmScreen({Key? key}) : super(key: key);

  @override
  State<FtConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<FtConfirmScreen> {
  void _onSubmitted() {
    context
        .read<FtCreateOutgoingTransferBloc>()
        .add(const FtCreateOutgoingTransferEvent.submitted());
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<FtCreateOutgoingTransferBloc, FtCreateOutgoingTransferState>(
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
              content = TokenCreateLinkContent(
                amount: state.tokenAmount,
                fee: state.fee,
              );
              break;
            case OutgoingTransferType.direct:
              content = SendTokenToSolanaAddressContent(
                amount: state.tokenAmount,
                fee: state.fee,
                address: state.recipientAddress ?? '',
              );
              break;
          }

          return CpTheme.dark(
            child: CpLoader(
              isLoading: state.flow.isProcessing(),
              child: Scaffold(
                appBar: CpAppBar(
                  title: const Text(
                    'PAY',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                  hasBorder: false,
                  leading: BackButton(onPressed: () => context.router.pop()),
                ),
                body: CpContentPadding(child: content),
                bottomNavigationBar: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: CpButton(
                    onPressed: _onSubmitted,
                    text: nextButtonText,
                  ),
                ),
              ),
            ),
          );
        },
      );
}

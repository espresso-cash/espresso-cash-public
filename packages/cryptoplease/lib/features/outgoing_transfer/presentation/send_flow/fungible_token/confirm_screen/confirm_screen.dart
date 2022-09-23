import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/presentation/dialogs.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/create_outgoing_transfer_bloc/ft/bloc.dart';
import 'package:cryptoplease/features/outgoing_transfer/bl/outgoing_payment.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/direct_content.dart';
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
          switch (state.transferType) {
            case OutgoingTransferType.splitKey:
              return _SplitKeyContent(
                onSubmitted: _onSubmitted,
                isProcessing: state.flow.isProcessing(),
                tokenAmount: state.tokenAmount,
                fee: state.fee,
              );
            case OutgoingTransferType.direct:
              return DirectContent(
                fee: state.fee,
                recipientAddress: state.recipientAddress ?? '',
                tokenAmount: state.tokenAmount,
                isProcessing: state.flow.isProcessing(),
                onSubmitted: _onSubmitted,
              );
          }
        },
      );
}

class _SplitKeyContent extends StatelessWidget {
  const _SplitKeyContent({
    Key? key,
    required this.onSubmitted,
    required this.isProcessing,
    required this.tokenAmount,
    required this.fee,
  }) : super(key: key);

  final VoidCallback onSubmitted;
  final bool isProcessing;
  final Amount tokenAmount;
  final Amount fee;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: CpLoader(
          isLoading: isProcessing,
          child: Scaffold(
            appBar: CpAppBar(
              title: Text(
                context.l10n.pay.toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
              hasBorder: false,
              leading: BackButton(onPressed: () => context.router.pop()),
            ),
            body: CpContentPadding(
              child: TokenCreateLinkContent(
                amount: tokenAmount,
                fee: fee,
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CpButton(
                onPressed: onSubmitted,
                text: context.l10n.create,
              ),
            ),
          ),
        ),
      );
}

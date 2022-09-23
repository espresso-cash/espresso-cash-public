import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/fungible_token/confirm_screen/components/send_token_to_solana_address_content.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class DirectContent extends StatelessWidget {
  const DirectContent({
    Key? key,
    required this.onSubmitted,
    required this.isProcessing,
    required this.tokenAmount,
    required this.fee,
    required this.recipientAddress,
  }) : super(key: key);

  final VoidCallback onSubmitted;
  final bool isProcessing;
  final Amount tokenAmount;
  final Amount fee;
  final String recipientAddress;

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: CpLoader(
          isLoading: isProcessing,
          child: Scaffold(
            appBar: CpAppBar(
              hasBorder: false,
              leading: BackButton(onPressed: () => context.router.pop()),
              nextButton: CpButton(
                onPressed: onSubmitted,
                text: context.l10n.send,
              ),
            ),
            body: CpContentPadding(
              child: SendTokenToSolanaAddressContent(
                amount: tokenAmount,
                fee: fee,
                address: recipientAddress,
              ),
            ),
          ),
        ),
      );
}

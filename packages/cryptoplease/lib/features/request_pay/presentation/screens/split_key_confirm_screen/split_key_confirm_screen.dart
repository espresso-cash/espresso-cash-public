import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/features/request_pay/presentation/screens/split_key_confirm_screen/components/token_create_link_content.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SplitKeyConfirmScreen extends StatelessWidget {
  const SplitKeyConfirmScreen({
    super.key,
    required this.tokenAmount,
    required this.fee,
    required this.onSubmit,
  });

  final Amount tokenAmount;
  final Amount fee;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
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
              onPressed: onSubmit,
              text: context.l10n.create,
            ),
          ),
        ),
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/info_icon.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/features/outgoing_transfer/presentation/send_flow/confirm_screen/components/amount_fee_view.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class OSKPConfirmationScreen extends StatelessWidget {
  const OSKPConfirmationScreen({
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
            child: _TokenCreateLinkContent(
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

class _TokenCreateLinkContent extends StatelessWidget {
  const _TokenCreateLinkContent({
    Key? key,
    required this.amount,
    required this.fee,
  }) : super(key: key);

  final Amount amount;
  final Amount fee;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            context.l10n.youAreCreatingUniqueLink,
            style: _mediumTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          AmountFeeView(
            amount: amount,
            fee: fee,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CpInfoWidget(
              icon: const InfoIcon(),
              message: Text(context.l10n.sendExplanation),
            ),
          ),
          const Spacer(),
        ],
      );
}

const _mediumTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);

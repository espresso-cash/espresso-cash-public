import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../landing/widgets/extensions.dart';
import '../../../../ui/button.dart';
import '../../../core/arrow.dart';
import '../../../core/divider.dart';
import '../../../core/page.dart';
import '../../../routes.gr.dart';
import '../../request/screens/link_screen.dart';
import 'other_wallet_screen.dart';
import 'solana_screen.dart';

@RoutePage()
class SenderRouterScreen extends AutoRouter {
  const SenderRouterScreen({super.key});
}

@RoutePage()
class SenderInitialScreen extends StatelessWidget {
  const SenderInitialScreen({
    super.key,
    @queryParam this.amount,
    @queryParam this.recipient,
    @queryParam this.reference,
  });

  final String? amount;
  final String? recipient;
  final String? reference;

  static const route = SenderInitialRoute.new;

  void _onSolanaPay(BuildContext context, SolanaPayRequest request) {
    final actionLink = Uri.parse(request.toUrl());

    if (isMobile) {
      launchUrl(
        actionLink,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => SolanaSendScreen(
            amount: request.amount.toString(),
            actionLink: actionLink,
          ),
        ),
      );
    }
  }

  void _onOtherWallet(BuildContext context, SolanaPayRequest request) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => OtherWalletScreen(request),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.createPayRequest(
      amount: amount!,
      receiver: recipient!,
      reference: reference!,
    );

    return PageWidget(
      children: [
        const Text(
          'You have a payment request in the amount of',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.23,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${amount ?? 0} USDC',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 41,
            fontWeight: FontWeight.w700,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 40),
        CpButton(
          text: 'Pay With USDC on Solana',
          size: CpButtonSize.big,
          width: 350,
          trailing: const Arrow(),
          onPressed: () => _onSolanaPay(context, request),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: DividerWidget(),
        ),
        CpButton(
          text: 'Other Payment Method',
          size: CpButtonSize.big,
          variant: CpButtonVariant.black,
          width: 350,
          trailing: const Arrow(
            color: Colors.white,
          ),
          onPressed: () => _onOtherWallet(context, request),
        ),
      ],
    );
  }
}

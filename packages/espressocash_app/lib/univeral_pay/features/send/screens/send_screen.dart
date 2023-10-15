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
import 'other_wallet_screen.dart';
import 'solana_screen.dart';

@RoutePage()
class SenderRouterScreen extends AutoRouter {
  const SenderRouterScreen({super.key});
}

@RoutePage()
class SenderInitialScreen extends StatelessWidget {
  const SenderInitialScreen(this.request, {super.key});

  final SolanaPayRequest request;

  static const route = SenderInitialRoute.new;

  void _onSolanaPay(BuildContext context) {
    final actionLink = Uri.parse(request.toUrl());

    if (isMobile) {
      launchUrl(
        actionLink,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      context.router.push(
        SolanaSendScreen.route(
          amount: request.amount.toString(),
          actionLink: actionLink,
        ),
      );
    }
  }

  void _onOtherWallet(BuildContext context) {
    context.router.push(
      OtherWalletScreen.route(request: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    final amount = request.amount.toString();

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
          '$amount USDC',
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
          onPressed: () => _onSolanaPay(context),
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
          onPressed: () => _onOtherWallet(context),
        ),
      ],
    );
  }
}

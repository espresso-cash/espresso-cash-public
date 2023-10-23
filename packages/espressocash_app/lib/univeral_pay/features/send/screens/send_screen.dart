import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../landing/widgets/extensions.dart';
import '../../../../ui/button.dart';
import '../../../core/arrow.dart';
import '../../../core/disclaimer.dart';
import '../../../core/divider.dart';
import '../../../core/page.dart';
import '../../../core/request_helpers.dart';
import '../../../routes.gr.dart';
import 'other_wallet_screen.dart';
import 'solana_screen.dart';

@RoutePage()
class SenderRouterScreen extends AutoRouter {
  const SenderRouterScreen({super.key});
}

@RoutePage()
class SenderInitialScreen extends StatefulWidget {
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

  @override
  State<SenderInitialScreen> createState() => _SenderInitialScreenState();
}

class _SenderInitialScreenState extends State<SenderInitialScreen> {
  bool _isDisclaimerAccepted = false;

  void _onSolanaPay(SolanaPayRequest request) {
    if (isMobile) {
      final actionLink = Uri.parse(request.toUrl());

      launchUrl(
        actionLink,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      context.router.navigate(
        SolanaSendScreen.route(
          amount: widget.amount,
          recipient: widget.recipient,
          reference: widget.reference,
        ),
      );
    }
  }

  void _onOtherWallet() {
    context.router.navigate(
      OtherWalletScreen.route(
        amount: widget.amount,
        recipient: widget.recipient,
        reference: widget.reference,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.createUniversalRequest(
      amount: widget.amount,
      receiver: widget.recipient,
      reference: widget.reference,
    );

    return request != null
        ? PageWidget(
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
                '${widget.amount ?? 0} USDC',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 41,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 40),
              DisclaimerCheckbox(
                value: _isDisclaimerAccepted,
                onChanged: (value) {
                  setState(() {
                    _isDisclaimerAccepted = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              CpButton(
                text: 'Pay With USDC on Solana',
                size: CpButtonSize.big,
                width: 350,
                trailing: const Arrow(),
                onPressed:
                    _isDisclaimerAccepted ? () => _onSolanaPay(request) : null,
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
                onPressed: _isDisclaimerAccepted ? _onOtherWallet : null,
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}

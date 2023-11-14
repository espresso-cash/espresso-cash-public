import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../core/blockchain.dart';
import '../../../core/desktop.dart';
import '../../../core/extensions.dart';
import '../../../core/landing_widget.dart';
import '../service/bloc.dart';
import '../widgets/arrow.dart';
import '../widgets/button.dart';
import '../widgets/page.dart';
import 'other_wallet_screen.dart';

class SendInitialScreen extends StatefulWidget {
  const SendInitialScreen(this.request, {super.key});

  final SolanaPayRequest request;

  @override
  State<SendInitialScreen> createState() => _SendInitialScreenState();
}

class _SendInitialScreenState extends State<SendInitialScreen> {
  void _onSolanaPay() {
    if (isMobile) {
      final actionLink = Uri.parse(widget.request.toUrl());

      launchUrl(
        actionLink,
        mode: LaunchMode.externalNonBrowserApplication,
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => EspressoDesktopView(
            actionLink: Uri.parse(widget.request.toUrl()),
            header: Text(
              '${context.l10n.landingPaymentRequestTitle} ${widget.request.amount ?? 0} USDC',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }
  }

  void _onOtherWallet(Blockchain chain) {
    if (chain == Blockchain.solana) {
      //TODO new page
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => BlocProvider(
          create: (context) => sl<UniversalPayCubit>(
            param1: widget.request,
            param2: chain,
          ),
          child: OtherWalletScreen(
            request: widget.request,
            chain: chain,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => isMobile
      ? RequestMobilePage(
          header: Container(),
          content: const Column(
            children: [], //TODO
          ),
        )
      : Scaffold(
          body: LandingDesktopWidget(
            header: Text(
              'has requested ${widget.request.amount ?? 0} USDC',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Payment method',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2D2B2C),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.23,
                    ),
                  ),
                ),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    'Express Checkout',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2D2B2C),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 0.07,
                    ),
                  ),
                ),
                CpButton(
                  text: context.l10n.landingPayEspresso,
                  size: CpButtonSize.big,
                  width: 700,
                  trailing: const Arrow(),
                  onPressed: _onSolanaPay,
                ),
                const SizedBox(height: 24),
                const Text(
                  'or select a cryptocurrency to pay with another wallet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2D2B2C),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.23,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  children: Blockchain.values
                      .map(
                        (e) => OtherWalletButton(
                          chain: e,
                          onTap: () => _onOtherWallet(e),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
}

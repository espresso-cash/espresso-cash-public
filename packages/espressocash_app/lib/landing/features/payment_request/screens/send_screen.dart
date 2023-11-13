import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../core/desktop.dart';
import '../../../core/extensions.dart';
import '../../../core/landing_widget.dart';
import '../../../core/presentation/header.dart';
import '../service/bloc.dart';
import '../widgets/arrow.dart';
import '../widgets/divider.dart';
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
            ),
          ),
        ),
      );
    }
  }

  void _onOtherWallet() => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => BlocProvider(
            create: (context) => sl<UniversalPayCubit>(
              param1: widget.request,
            ),
            child: OtherWalletScreen(request: widget.request),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LandingMobileWidget(
          children: [
            const EspressoHeader(),
            Text(
              context.l10n.landingPaymentRequestTitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.request.amount ?? 0} USDC',
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
              text: context.l10n.landingPayEspresso,
              size: CpButtonSize.big,
              width: 350,
              trailing: const Arrow(),
              onPressed: _onSolanaPay,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: DividerWidget(),
            ),
            CpButton(
              text: context.l10n.landingPayOtherWallet,
              size: CpButtonSize.big,
              variant: CpButtonVariant.black,
              width: 350,
              trailing: const Arrow(
                color: Colors.white,
              ),
              onPressed: _onOtherWallet,
            ),
          ],
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../features/blockchain/models/blockchain.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../core/desktop.dart';
import '../../../core/extensions.dart';
import '../../../core/landing_widget.dart';
import '../widgets/arrow.dart';
import '../widgets/button.dart';
import '../widgets/divider.dart';
import '../widgets/invoice.dart';
import '../widgets/page.dart';
import 'solana_wallet_screen.dart';

class RequestInitialScreen extends StatefulWidget {
  const RequestInitialScreen(this.request, {super.key});

  final SolanaPayRequest request;

  @override
  State<RequestInitialScreen> createState() => _RequestInitialScreenState();
}

class _RequestInitialScreenState extends State<RequestInitialScreen> {
  void _onSolanaPay() {
    if (isMobile) {
      final actionLink = Uri.parse(widget.request.toUrl());

      launchUrl(
        actionLink,
        mode: LaunchMode.externalNonBrowserApplication,
        webOnlyWindowName: '_self',
      );
    } else {
      final page = EspressoDesktopView(
        actionLink: Uri.parse(widget.request.toUrl()),
        header: HeaderDesktop(
          title: widget.request.headerTitle,
          showBackButton: true,
        ),
      );

      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (context) => page));
    }
  }

  void _onOtherWallet(BuildContext context, Blockchain chain) {
    final Widget page;

    if (isMobile && chain == Blockchain.solana) {
      final actionLink = Uri.parse(widget.request.toUrl());

      launchUrl(
        actionLink,
        mode: LaunchMode.externalNonBrowserApplication,
        webOnlyWindowName: '_self',
      );

      return;
    }

    page = SolanaWalletScreen(
      title: widget.request.headerTitle,
      actionLink: Uri.parse(widget.request.toUrl()),
    );

    // if (chain == Blockchain.solana) {
    //   page = SolanaWalletScreen(
    //     title: widget.request.headerTitle,
    //     actionLink: Uri.parse(widget.request.toUrl()),
    //   );
    // } else {
    //   page = MultiBlocProvider(
    //     providers: [
    //       BlocProvider(
    //         create: (context) => sl<UniversalPayBloc>(
    //           param1: widget.request,
    //           param2: chain,
    //         ),
    //       ),
    //       BlocProvider<RequestVerifierBloc>.value(
    //         value: context.read<RequestVerifierBloc>(),
    //       ),
    //       Provider.value(value: widget.request),
    //     ],
    //     child: OtherWalletScreen(chain: chain),
    //   );
    // }

    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => isMobile
            ? _MobileView(
                request: widget.request,
                onEspressoPay: _onSolanaPay,
                onOtherWallet: (chain) => _onOtherWallet(context, chain),
              )
            : _DesktopView(
                request: widget.request,
                onEspressoPay: _onSolanaPay,
                onOtherWallet: (chain) => _onOtherWallet(context, chain),
              ),
      );
}

class _MobileView extends StatelessWidget {
  const _MobileView({
    required this.request,
    required this.onEspressoPay,
    required this.onOtherWallet,
  });

  final SolanaPayRequest request;
  final VoidCallback onEspressoPay;
  final void Function(Blockchain chain) onOtherWallet;

  @override
  Widget build(BuildContext context) => RequestMobilePage(
        header: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              request.label == null
                  ? 'You have a request of'
                  : '${request.label} has requested',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            Text(
              '${request.amount ?? 0} USDC',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
          ],
        ),
        content: Column(
          children: [
            const SizedBox(height: 26),
            Text(
              context.l10n.landingExpressCheckout,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 16),
            CpButton(
              text: context.l10n.landingPayEspresso,
              size: CpButtonSize.big,
              width: 340,
              trailing: const Arrow(),
              onPressed: onEspressoPay,
            ),
            const DividerWidget(),
            Text(
              context.l10n.landingPayOtherWallet,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 12),
            ...Blockchain.values.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: OtherWalletButton(
                  chain: e,
                  onTap: () => onOtherWallet(e),
                ),
              ),
            ),
            if (request.reference?.first case final reference?) ...[
              const SizedBox(height: 24),
              InvoiceWidget(address: reference.toBase58()),
              const SizedBox(height: 4),
            ],
          ],
        ),
      );
}

class _DesktopView extends StatelessWidget {
  const _DesktopView({
    required this.request,
    required this.onEspressoPay,
    required this.onOtherWallet,
  });

  final SolanaPayRequest request;
  final VoidCallback onEspressoPay;
  final void Function(Blockchain chain) onOtherWallet;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LandingDesktopWidget(
          header: HeaderDesktop(title: request.headerTitle),
          content: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 26, bottom: 18),
                child: Text(
                  context.l10n.landingPaymentMethod,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF2D2B2C),
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.23,
                  ),
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Text(
                  context.l10n.landingExpressCheckout,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF2D2B2C),
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.23,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CpButton(
                  text: context.l10n.landingPayEspresso,
                  size: CpButtonSize.big,
                  width: 780,
                  trailing: const Arrow(),
                  onPressed: onEspressoPay,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                context.l10n.landingPayOtherWallet2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF2D2B2C),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.23,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                children: Blockchain.values
                    .map(
                      (e) => OtherWalletButton(
                        chain: e,
                        onTap: () => onOtherWallet(e),
                      ),
                    )
                    .toList(),
              ),
              if (request.reference?.first case final reference?) ...[
                const Spacer(),
                InvoiceWidget(address: reference.toBase58()),
                const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      );
}

extension on SolanaPayRequest {
  String get headerTitle {
    final name = label;
    final amount = this.amount ?? 0;

    return name == null
        ? 'You have a request of $amount USDC'
        : '$name has requested $amount USDC';
  }

  String get actionText {
    final name = label;

    return name == null ? 'Pay' : 'Pay $name';
  }
}

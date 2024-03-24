import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/snackbar.dart';
import '../../../core/extensions.dart';
import '../../../di.dart';
import '../../../ui/arrow.dart';
import '../../../ui/colors.dart';
import '../../../ui/desktop_page.dart';
import '../../../ui/mobile_page.dart';
import '../../web3/models/exception.dart';
import '../../web3/web3_service.dart';
import '../widgets/button.dart';
import '../widgets/divider.dart';
import '../widgets/extensions.dart';
import '../widgets/invoice.dart';
import 'espresso_request_screen.dart';
import 'other_wallet_screen.dart';
import 'solana_wallet_screen.dart';

class RequestInitialScreen extends StatefulWidget {
  const RequestInitialScreen(this.request, {super.key});

  final SolanaPayRequest request;

  @override
  State<RequestInitialScreen> createState() => _RequestInitialScreenState();
}

class _RequestInitialScreenState extends State<RequestInitialScreen> {
  void _onEspressoPay() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => EspressoRequestScreen(request: widget.request),
      ),
    );
  }

  void _onSolanaPay() {
    if (isMobile) {
      final actionLink = Uri.parse(widget.request.toUrl());

      launchUrl(
        actionLink,
        mode: LaunchMode.externalNonBrowserApplication,
        webOnlyWindowName: '_self',
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => SolanaWalletScreen(
            title: widget.request.headerTitle,
            request: widget.request,
          ),
        ),
      );
    }
  }

  Future<void> _onMetaMaskPay() async {
    try {
      final service = sl<Web3Service>();

      await service.connect();

      if (!context.mounted) return;

      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => OtherWalletScreen(request: widget.request),
        ),
      );
    } on Web3Exception catch (error) {
      if (!context.mounted) return;

      showCpErrorSnackbar(
        context,
        message: switch (error) {
          MetaMaskNotInstalled() => context.l10n.metamaskNotInstalled,
          UserRejected() => context.l10n.metamaskRejected,
          OtherException() => context.l10n.genericError,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => isMobile
            ? _Mobile(
                request: widget.request,
                onEspressoPay: _onEspressoPay,
                onMetaMaskPay: _onMetaMaskPay,
                onSolanaPay: _onSolanaPay,
              )
            : _Desktop(
                request: widget.request,
                onEspressoPay: _onEspressoPay,
                onMetaMaskPay: _onMetaMaskPay,
                onSolanaPay: _onSolanaPay,
              ),
      );
}

class _Mobile extends StatelessWidget {
  const _Mobile({
    required this.request,
    required this.onEspressoPay,
    required this.onMetaMaskPay,
    required this.onSolanaPay,
  });

  final SolanaPayRequest request;
  final VoidCallback onEspressoPay;
  final VoidCallback onMetaMaskPay;
  final VoidCallback onSolanaPay;

  @override
  Widget build(BuildContext context) => LandingMobilePage(
        header: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              request.label == null
                  ? context.l10n.requestTitle
                  : context.l10n.userRequestingTitle(request.label ?? ''),
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
            const SizedBox(height: 48),
            Text(
              context.l10n.expressCheckout,
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
              text: context.l10n.payEspresso,
              size: CpButtonSize.big,
              width: 340,
              trailing: const LandingArrow(),
              onPressed: onEspressoPay,
            ),
            const DividerWidget(),
            Text(
              context.l10n.payOtherWallet,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 16),
            if (sl<Web3Service>().isEnabled)
              WalletButton(
                label: 'Metamask',
                icon: Assets.images.metamask,
                onTap: onMetaMaskPay,
              ),
            WalletButton(
              label: 'Solana Wallet',
              icon: Assets.images.solanaLogo,
              onTap: onSolanaPay,
            ),
            const SizedBox(height: 12),
            if (request.reference?.first case final reference?) ...[
              const SizedBox(height: 24),
              InvoiceWidget(address: reference.toBase58()),
            ],
          ],
        ),
      );
}

class _Desktop extends StatelessWidget {
  const _Desktop({
    required this.request,
    required this.onEspressoPay,
    required this.onSolanaPay,
    required this.onMetaMaskPay,
  });

  final SolanaPayRequest request;
  final VoidCallback onEspressoPay;
  final VoidCallback onMetaMaskPay;
  final VoidCallback onSolanaPay;

  @override
  Widget build(BuildContext context) => LandingDesktopPage(
        title: request.headerTitle,
        content: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            Text(
              context.l10n.expressCheckout,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CpButton(
                text: context.l10n.payEspresso,
                size: CpButtonSize.big,
                width: 500,
                trailing: const LandingArrow(),
                onPressed: onEspressoPay,
              ),
            ),
            const Spacer(),
            const Divider(color: EcLandingColors.borderColor),
            const Spacer(),
            Text(
              context.l10n.payOtherWallet,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 16),
            if (sl<Web3Service>().isEnabled)
              WalletButton(
                label: 'Metamask',
                icon: Assets.images.metamask,
                onTap: onMetaMaskPay,
              ),
            WalletButton(
              label: 'Solana Wallet',
              icon: Assets.images.solanaLogo,
              onTap: onSolanaPay,
            ),
            if (request.reference?.first case final reference?) ...[
              const Spacer(),
              InvoiceWidget(address: reference.toBase58()),
            ],
          ],
        ),
      );
}

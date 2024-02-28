import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/snackbar.dart';
import '../../../core/espresso_desktop.dart';
import '../../../core/extensions.dart';
import '../../../core/landing_desktop.dart';
import '../../../di.dart';
import '../../web3/models/exception.dart';
import '../../web3/web3_service.dart';
import '../service/bloc.dart';
import '../widgets/arrow.dart';
import '../widgets/button.dart';
import '../widgets/invoice.dart';
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
        title: widget.request.headerTitle,
        subtitle: 'To complete the transaction, follow the steps below.',
      );

      Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: (context) => page));
    }
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

      final page = MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<IncomingPaymentBloc>()),
        ],
        child: OtherWalletScreen(request: widget.request),
      );

      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => page,
        ),
      );
    } on Web3Exception catch (error) {
      if (!context.mounted) return;

      showCpErrorSnackbar(
        context,
        message: switch (error) {
          MetaMaskNotInstalled() => 'MetaMask is not installed',
          UserRejected() => 'User rejected the request',
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) => Builder(
        builder: (context) => _DesktopView(
          request: widget.request,
          onEspressoPay: _onEspressoPay,
          onMetaMaskPay: _onMetaMaskPay,
          onSolanaPay: _onSolanaPay,
        ),
        // builder: (context) => isMobile
        //     ? _MobileView(
        //         request: widget.request,
        //         onEspressoPay: _onSolanaPay,
        //         onOtherWallet: (chain) => _onOtherWallet(context, chain),
        //       )
        //     : _DesktopView(
        //         request: widget.request,
        //         onEspressoPay: _onSolanaPay,
        //         onMetaMaskPay: _onMetaMaskPay,
        //         onSolanaPay: _onSolanaPay,
        //       ),
      );
}

// class _MobileView extends StatelessWidget {
//   const _MobileView({
//     required this.request,
//     required this.onEspressoPay,
//     required this.onOtherWallet,
//   });

//   final SolanaPayRequest request;
//   final VoidCallback onEspressoPay;
//   final void Function(Blockchain chain) onOtherWallet;

//   @override
//   Widget build(BuildContext context) => RequestMobilePage(
//         header: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               request.label == null
//                   ? 'You have a request of'
//                   : '${request.label} has requested',
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 23,
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 0.23,
//               ),
//             ),
//             Text(
//               '${request.amount ?? 0} USDC',
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 45,
//                 fontWeight: FontWeight.w700,
//                 letterSpacing: -1,
//               ),
//             ),
//           ],
//         ),
//         content: Column(
//           children: [
//             const SizedBox(height: 26),
//             Text(
//               context.l10n.landingExpressCheckout,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Color(0xFF2D2B2C),
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 0.23,
//               ),
//             ),
//             const SizedBox(height: 16),
//             CpButton(
//               text: context.l10n.landingPayEspresso,
//               size: CpButtonSize.big,
//               width: 340,
//               trailing: const Arrow(),
//               onPressed: onEspressoPay,
//             ),
//             const DividerWidget(),
//             Text(
//               context.l10n.landingPayOtherWallet,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Color(0xFF2D2B2C),
//                 fontSize: 17,
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 0.23,
//               ),
//             ),
//             const SizedBox(height: 12),
//             ..._supportedChains.map(
//               (e) => Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: WalletButton(
//                   chain: e,
//                   onTap: () => onOtherWallet(e),
//                 ),
//               ),
//             ),
//             if (request.reference?.first case final reference?) ...[
//               const SizedBox(height: 24),
//               InvoiceWidget(address: reference.toBase58()),
//               const SizedBox(height: 4),
//             ],
//           ],
//         ),
//       );
// }

class _DesktopView extends StatelessWidget {
  const _DesktopView({
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
              context.l10n.landingExpressCheckout,
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
                text: context.l10n.landingPayEspresso,
                size: CpButtonSize.big,
                width: 500,
                trailing: const Arrow(),
                onPressed: onEspressoPay,
              ),
            ),
            const Spacer(),
            const Divider(color: borderColor),
            const Spacer(),
            const Text(
              'or pay with a crypto-wallet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const SizedBox(height: 16),
            WalletButton(
              label: 'Metamask',
              icon: Assets.landing.metamask,
              onTap: onMetaMaskPay,
            ),
            const SizedBox(height: 8),
            WalletButton(
              label: 'Solana Wallet',
              icon: Assets.landing.solanaLogo,
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

extension on SolanaPayRequest {
  String get headerTitle {
    final name = label;
    final amount = this.amount ?? 0;

    return name == null
        ? 'You have a request of $amount USDC'
        : '$name is requesting $amount USDC';
  }
}

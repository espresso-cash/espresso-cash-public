import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';
import '../../../core/blockchain.dart';
import '../../../core/landing_widget.dart';
import '../../../core/presentation/qr_code.dart';
import '../service/bloc.dart';

class OtherWalletScreen extends StatelessWidget {
  const OtherWalletScreen({
    super.key,
    required this.request,
    required this.chain,
  });

  final SolanaPayRequest request;
  final Blockchain chain;

  @override
  Widget build(BuildContext context) {
    const fee = 1.1;
    const evmAddress = '0x4838B106FCe9647Bdf1E7877BF73cE8B0BAD5f97';

    return Scaffold(
      body: LandingDesktopWidget(
        header: Text(
          'Pay Antoine with USDC on ${chain.name} network',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF2D2B2C),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Column(
          children: [
            const Text(
              'Open your crypto wallet and scan the QR code, or copy the USDC address below to make a payment.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 19,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0),
              child: QrWidget(code: evmAddress),
            ),
            Text(
              '${chain.name} Address',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            const _BubbleWidget(
              content: Text(
                evmAddress,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              textToCopy: evmAddress,
            ),
            const Text(
              'Total Amount',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 17,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.23,
              ),
            ),
            _BubbleWidget(
              content: Column(
                children: [
                  Text(
                    '${request.amount ?? ''} USDC',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Includes a ${chain.name} Network Fee of $fee USDC',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textToCopy: fee.toString(),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) =>
  //     BlocBuilder<UniversalPayCubit, UniversalPayState>(
  //       builder: (context, state) {
  //         final fee = state.fees[state.selectedBlockchain] ?? 0.0;

  //         return CpLoader(
  //           isLoading: state.processingState.isProcessing,
  //           child: Scaffold(
  //             body: LandingMobileWidget(
  //               children: [
  //                 const EspressoHeader(),
  //                 Text(
  //                   '${context.l10n.landingPaymentRequestTitle} ${request.amount ?? 0} USDC',
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 26,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 42),
  //                 Text(
  //                   context.l10n.landingPaymentMethod,
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 19,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 _PaymentMethodDropdown(
  //                   current: state.selectedBlockchain,
  //                   onChanged:
  //                       context.read<UniversalPayCubit>().changeBlockchain,
  //                 ),
  //                 const SizedBox(height: 32),
  //                 Text(
  //                   context.l10n.landingDestinationAddress,
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 19,
  //                     fontWeight: FontWeight.w500,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 8),
  //                 _DestinationWidget(
  //                   address: state.destinationEvmAddress,
  //                 ),
  //                 const SizedBox(height: 32),
  //                 Text(
  //                   context.l10n.landingNetworkFee(fee.toString()),
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 19,
  //                     fontWeight: FontWeight.w600,
  //                     letterSpacing: 0.23,
  //                   ),
  //                 ),
  //                 const SizedBox(height: 4),
  //                 Text(
  //                   context.l10n.landingTotalAmount(state.totalAmount ?? ''),
  //                   textAlign: TextAlign.center,
  //                   style: const TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 24,
  //                     fontWeight: FontWeight.w700,
  //                     letterSpacing: 0.23,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       },
  //     );
}

class _BubbleWidget extends StatelessWidget {
  const _BubbleWidget({
    required this.content,
    required this.textToCopy,
  });

  final Widget content;
  final String textToCopy;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: CpRoundedRectangle(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          backgroundColor: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: content),
              CpButton(
                text: context.l10n.copy,
                minWidth: 80,
                onPressed: () {
                  final data = ClipboardData(text: textToCopy);
                  Clipboard.setData(data);
                  showClipboardSnackbar(context);
                },
                size: CpButtonSize.small,
              ),
            ],
          ),
        ),
      );
}

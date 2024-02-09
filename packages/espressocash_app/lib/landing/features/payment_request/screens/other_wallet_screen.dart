import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';
import '../../../core/extensions.dart';
import '../../../core/landing_widget.dart';
import '../../../di.dart';
import '../models/request_model.dart';
import '../service/bloc.dart';
import '../widgets/countdown.dart';
import '../widgets/invoice.dart';

class OtherWalletScreen extends StatefulWidget {
  const OtherWalletScreen({
    super.key,
    required this.chain,
    required this.request,
  });

  final Blockchain chain;
  final SolanaPayRequest request;

  @override
  State<OtherWalletScreen> createState() => _OtherWalletScreenState();
}

class _OtherWalletScreenState extends State<OtherWalletScreen> {
  // late final IncomingPaymentBloc _bloc;

  @override
  void initState() {
    super.initState();

    final request = widget.request;

    // _bloc = sl<IncomingPaymentBloc>();

    sl<IncomingPaymentBloc>().add(
      IncomingPaymentEvent.init(
        IncomingPaymentRequest(
          receiverAddress: request.recipient.toBase58(),
          requestAmount: Amount.fromDecimal(
            value: request.amount!,
            currency: Currency.usdc,
          ) as CryptoAmount,
          solanaReferenceAddress: request.reference?.first.toBase58(),
          receiverName: request.label,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => const Scaffold(
        // body: isMobile ? const _MobileView() : const _DesktopView(),
        body: _DesktopView(),
      );
}

// class _MobileView extends StatelessWidget {
//   const _MobileView();

//   @override
//   Widget build(BuildContext context) =>
//       BlocBuilder<IncomingPaymentBloc, IncomingPaymentState>(
//         builder: (context, state) {
//           final chain = state.selectedChain ?? Blockchain.solana;
//           final request = context.read<SolanaPayRequest>();

//           final String title =
//               'Pay ${request.label ?? ''} with USDC on ${chain.name} network';

//           return CpLoader(
//             isLoading: state.processingState.isProcessing,
//             child: RequestMobilePage(
//               header: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: CountdownTimer(expiryDate: state.expiresAt),
//                     ),
//                   ),
//                   Align(
//                     child: QrWidget(code: state.destinationEvmAddress),
//                   ),
//                 ],
//               ),
//               content: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 24),
//                     const RequestStatus(),
//                     Container(
//                       width: 75,
//                       height: 75,
//                       decoration: const ShapeDecoration(
//                         color: Color(0xFFEFEFEF),
//                         shape: OvalBorder(),
//                       ),
//                       child: Center(
//                         child: UsdcLogoWidget(chain, size: 38),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         title,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 0.23,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 28),
//                     Text(
//                       '${chain.name} Address',
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Color(0xFF2D2B2C),
//                         fontSize: 17,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 0.23,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     _BubbleWidget(
//                       content: Text(
//                         state.destinationEvmAddress,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       textToCopy: state.destinationEvmAddress,
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       context.l10n.landingTotalAmount,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Color(0xFF2D2B2C),
//                         fontSize: 17,
//                         fontWeight: FontWeight.w500,
//                         letterSpacing: 0.23,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     _BubbleWidget(
//                       content: Column(
//                         children: [
//                           Text(
//                             '${state.totalAmount ?? ''} USDC',
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           Text(
//                             context.l10n.landingNetworkFee(
//                               chain.name,
//                               '${state.fee ?? '0'}',
//                             ),
//                             textAlign: TextAlign.center,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                         ],
//                       ),
//                       textToCopy: state.fee.toString(),
//                     ),
//                     if (request.reference?.first case final reference?) ...[
//                       const SizedBox(height: 24),
//                       InvoiceWidget(address: reference.toBase58()),
//                       const SizedBox(height: 4),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       );
// }

class _DesktopView extends StatelessWidget {
  const _DesktopView();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<IncomingPaymentBloc, IncomingPaymentState>(
        builder: (context, state) {
          final request = state.request;
          final chain = state.sender?.blockchain;

          final chainLabel =
              chain != null ? 'on ${chain.displayName} network' : '';

          final String title =
              'Pay ${request?.receiverName ?? ''} with USDC $chainLabel';

          return CpLoader(
            isLoading: state.flowState.isProcessing,
            child: LandingDesktopWidget(
              header: HeaderDesktop(
                title: title,
                trailing: CountdownTimer(expiryDate: state.expiresAt),
                showBackButton: true,
              ),
              content: Column(
                children: [
                  const SizedBox(height: 26),
                  CpButton(
                    text: 'Connect wallet',
                    onPressed: () {
                      sl<IncomingPaymentBloc>().add(
                        const IncomingPaymentEvent.onChangeWallet(
                          UserWalletInfo(
                            address:
                                '0x43b2595b3e6C200EBfd7F058dddF9403Ac457c1D',
                            blockchain: Blockchain.ethereum,
                          ),
                        ),
                      );
                    },
                  ),
                  // const RequestStatus(),
                  // Text(
                  //   context.l10n.landingPayRequestInstruction,
                  //   textAlign: TextAlign.center,
                  //   style: const TextStyle(
                  //     color: Colors.black,
                  //     fontSize: 19,
                  //     fontWeight: FontWeight.w500,
                  //     letterSpacing: 0.23,
                  //   ),
                  // ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  // Text(
                  //   context.l10n.landingTotalAmount,
                  //   textAlign: TextAlign.center,
                  //   style: const TextStyle(
                  //     color: Color(0xFF2D2B2C),
                  //     fontSize: 17,
                  //     fontWeight: FontWeight.w500,
                  //     letterSpacing: 0.23,
                  //   ),
                  // ),
                  const SizedBox(height: 4),
                  // _BubbleWidget(
                  //   content: Column(
                  //     children: [
                  //       Text(
                  //         '${state.totalAmount ?? ''} USDC',
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //       Text(
                  //         context.l10n.landingNetworkFee(
                  //           chain,
                  //           '${state.fee ?? '0'}',
                  //         ),
                  //         textAlign: TextAlign.center,
                  //         style: const TextStyle(
                  //           color: Colors.white,
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  if (request?.solanaReferenceAddress
                      case final reference?) ...[
                    const Spacer(),
                    const SizedBox(height: 24),
                    InvoiceWidget(address: reference),
                  ],
                ],
              ),
            ),
          );
        },
      );
}

class _BubbleWidget extends StatelessWidget {
  const _BubbleWidget({
    required this.content,
    required this.textToCopy,
  });

  final Widget content;
  final String textToCopy;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
        constraints: const BoxConstraints(maxWidth: 780),
        child: CpRoundedRectangle(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          backgroundColor: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: content),
              const SizedBox(width: 4),
              CpButton(
                text: context.l10n.copy,
                minWidth: 80,
                onPressed: () {
                  final data = ClipboardData(text: textToCopy);
                  Clipboard.setData(data);
                  showClipboardSnackbar(context);
                },
                size: isMobile ? CpButtonSize.micro : CpButtonSize.small,
              ),
            ],
          ),
        ),
      );
}

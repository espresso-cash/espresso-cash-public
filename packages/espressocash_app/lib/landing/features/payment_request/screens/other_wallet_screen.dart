import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../ui/button.dart';
import '../../../../ui/loader.dart';
import '../../../core/landing_widget.dart';
import '../../../di.dart';
import '../models/request_model.dart';
import '../service/bloc.dart';
import '../widgets/countdown.dart';
import '../widgets/dropdown.dart';
import '../widgets/invoice.dart';

class OtherWalletScreen extends StatefulWidget {
  const OtherWalletScreen({
    super.key,
    required this.request,
  });

  final SolanaPayRequest request;

  @override
  State<OtherWalletScreen> createState() => _OtherWalletScreenState();
}

class _OtherWalletScreenState extends State<OtherWalletScreen> {
  final _bloc = sl<IncomingPaymentBloc>();

  @override
  void initState() {
    super.initState();

    final request = widget.request;

    _bloc.add(
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

  void _onChainChanged(Blockchain chain) {
    _bloc.add(IncomingPaymentEvent.chainChanged(chain));
  }

  void _onConfirmed() {
    _bloc.add(const IncomingPaymentEvent.confirmed());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // body: isMobile ? const _MobileView() : const _DesktopView(),
        body: _DesktopView(
          onConfirm: _onConfirmed,
          onChainChanged: _onChainChanged,
        ),
      );
}

class _DesktopView extends StatelessWidget {
  const _DesktopView({
    required this.onConfirm,
    required this.onChainChanged,
  });

  final VoidCallback onConfirm;
  final ValueChanged<Blockchain> onChainChanged;

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
                  BlockchainDropDown(
                    current: chain ?? Blockchain.ethereum,
                    onBlockchainChanged: onChainChanged,
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Amount Requested'),
                      const Spacer(),
                      Text(
                        state.inputAmount.format(context.locale),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Network Fee'),
                      const Spacer(),
                      Text(
                        state.fee.format(context.locale),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      const Text('Total'),
                      const Spacer(),
                      Text(
                        state.totalAmount.format(context.locale),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CpButton(
                    text: 'Pay Now',
                    onPressed: state.quote != null ? onConfirm : null,
                  ),
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

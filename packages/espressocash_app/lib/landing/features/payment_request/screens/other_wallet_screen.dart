import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../core/amount.dart';
import '../../../../core/currency.dart';
import '../../../../core/presentation/format_amount.dart';
import '../../../../features/blockchain/models/blockchain.dart';
import '../../../../l10n/device_locale.dart';
import '../../../../ui/arrow.dart';
import '../../../../ui/button.dart';
import '../../../../ui/loader.dart';
import '../../../core/landing_desktop.dart';
import '../../../di.dart';
import '../models/request_model.dart';
import '../service/bloc.dart';
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

  // isMobile ? const _MobileView() : const _DesktopView(),
  @override
  Widget build(BuildContext context) => _DesktopView(
        onConfirm: _onConfirmed,
        onChainChanged: _onChainChanged,
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

          final inputAmount =
              request?.requestAmount.format(context.locale, maxDecimals: 2) ??
                  0;

          final receiver = request?.receiverName != null
              ? 'to ${request?.receiverName}'
              : '';

          final String title = 'Pay $inputAmount $receiver';

          return CpLoader(
            isLoading: state.flowState.isProcessing,
            child: LandingDesktopPage(
              title: title,
              content: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Payment network',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 24),
                      BlockchainDropDown(
                        current: chain ?? Blockchain.ethereum,
                        onBlockchainChanged: onChainChanged,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: borderColor),
                  const Spacer(),
                  _Content(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Amount Requested',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            state.inputAmount
                                .format(context.locale, maxDecimals: 2),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Network Fee',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            state.fee.format(context.locale, maxDecimals: 2),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            state.totalAmount
                                .format(context.locale, maxDecimals: 2),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      CpButton(
                        text: 'Pay with Metamask',
                        size: CpButtonSize.big,
                        width: 500,
                        trailing: const Arrow(),
                        onPressed: state.quote != null ? onConfirm : null,
                      ),
                    ],
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

class _Content extends StatelessWidget {
  const _Content({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: children,
          ),
        ),
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

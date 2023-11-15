import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/button.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';
import '../../../core/blockchain.dart';
import '../../../core/extensions.dart';
import '../../../core/landing_widget.dart';
import '../../../core/presentation/qr_code.dart';
import '../service/bloc.dart';
import '../widgets/button.dart';
import '../widgets/countdown.dart';
import '../widgets/invoice.dart';
import '../widgets/page.dart';

class OtherWalletScreen extends StatefulWidget {
  const OtherWalletScreen({
    super.key,
    required this.chain,
  });

  final Blockchain chain;

  @override
  State<OtherWalletScreen> createState() => _OtherWalletScreenState();
}

class _OtherWalletScreenState extends State<OtherWalletScreen> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer(DateTime? expiresAt) {
    _timer?.cancel();
    if (expiresAt == null) return;
    _timer = Timer(expiresAt.difference(DateTime.now()), _onRefresh);
  }

  void _onRefresh() => context.read<UniversalPayBloc>().refreshPrice();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<UniversalPayBloc, UniversalPayState>(
          listenWhen: (prev, cur) => prev.expiresAt != cur.expiresAt,
          listener: (context, state) => _resetTimer(state.expiresAt),
          child: isMobile ? const _MobileView() : const _DesktopView(),
        ),
      );
}

class _MobileView extends StatelessWidget {
  const _MobileView();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UniversalPayBloc, UniversalPayState>(
        builder: (context, state) {
          final chain = state.selectedChain ?? Blockchain.solana;
          final request = context.read<SolanaPayRequest>();

          final String title =
              'Pay ${request.label ?? ''} with USDC on $chain network';

          return CpLoader(
            isLoading: state.processingState.isProcessing,
            child: RequestMobilePage(
              header: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: CountdownTimer(expiryDate: state.expiresAt),
                    ),
                  ),
                  Align(
                    child: QrWidget(code: state.destinationEvmAddress),
                  ),
                ],
              ),
              content: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: 75,
                      height: 75,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFEFEFEF),
                        shape: OvalBorder(),
                      ),
                      child: Center(
                        child: UsdcLogoWidget(
                          chain,
                          size: 45,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.23,
                      ),
                    ),
                    const SizedBox(height: 24),
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
                    _BubbleWidget(
                      content: Text(
                        state.destinationEvmAddress,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      textToCopy: state.destinationEvmAddress,
                    ),
                    Text(
                      context.l10n.landingTotalAmount,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                            '${state.totalAmount ?? ''} USDC',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            context.l10n.landingNetworkFee(
                              chain.name,
                              state.fee.toString(),
                            ),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      textToCopy: state.fee.toString(),
                    ),
                    if (request.reference?.first case final reference?)
                      InvoiceWidget(address: reference.toBase58()),
                  ],
                ),
              ),
            ),
          );
        },
      );
}

class _DesktopView extends StatelessWidget {
  const _DesktopView();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UniversalPayBloc, UniversalPayState>(
        builder: (context, state) {
          final chain = state.selectedChain?.name ?? '';
          final request = context.read<SolanaPayRequest>();

          final String title =
              'Pay ${request.label ?? ''} with USDC on $chain network';

          return CpLoader(
            isLoading: state.processingState.isProcessing,
            child: LandingDesktopWidget(
              header: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CpBackButton(),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF2D2B2C),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CountdownTimer(expiryDate: state.expiresAt),
                  ],
                ),
              ),
              content: Column(
                children: [
                  Text(
                    context.l10n.landingPayRequestInstruction,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.23,
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: QrWidget(code: state.destinationEvmAddress),
                  ),
                  Text(
                    '$chain Address',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF2D2B2C),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.23,
                    ),
                  ),
                  _BubbleWidget(
                    content: Text(
                      state.destinationEvmAddress,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    textToCopy: state.destinationEvmAddress,
                  ),
                  Text(
                    context.l10n.landingTotalAmount,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                          '${state.totalAmount ?? ''} USDC',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          context.l10n.landingNetworkFee(
                            chain,
                            state.fee.toString(),
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textToCopy: state.totalAmount.toString(),
                  ),
                  if (request.reference?.first case final reference?)
                    InvoiceWidget(address: reference.toBase58()),
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

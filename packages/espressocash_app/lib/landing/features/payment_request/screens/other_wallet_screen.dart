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
import '../../../core/landing_widget.dart';
import '../../../core/presentation/qr_code.dart';
import '../service/bloc.dart';
import '../widgets/countdown.dart';

class OtherWalletScreen extends StatefulWidget {
  const OtherWalletScreen({
    super.key,
    required this.request,
    required this.chain,
  });

  final SolanaPayRequest request;
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

  void _onRefresh() => context.read<UniversalPayCubit>().refreshPrice();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<UniversalPayCubit, UniversalPayState>(
          listenWhen: (prev, cur) => prev.expiresAt != cur.expiresAt,
          listener: (context, state) => _resetTimer(state.expiresAt),
          child: const _DesktopView(),
        ),
      );
}

class _DesktopView extends StatefulWidget {
  const _DesktopView();

  @override
  State<_DesktopView> createState() => __DesktopViewState();
}

class __DesktopViewState extends State<_DesktopView> {
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<UniversalPayCubit, UniversalPayState>(
        builder: (context, state) {
          final chain = state.selectedChain?.name ?? '';

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
                      'Pay Antoine with USDC on $chain network',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF2D2B2C),
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    CountdownTimer(
                      expiryDate: state.expiresAt ?? DateTime.now(),
                    ),
                  ],
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
                          '${state.totalAmount ?? ''} USDC',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Includes a $chain Network Fee of ${state.fee ?? ''} USDC',
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

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solana/solana_pay.dart';

import '../../../../ui/loader.dart';
import '../../../core/page.dart';
import '../../../core/request_helpers.dart';
import '../../../routes.gr.dart';
import '../../verifier/widgets/request_verifier.dart';
import '../../verifier/widgets/timeline_status.dart';
import '../data/repository.dart';
import '../service/universal_pay_bloc.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/destination_address.dart';
import '../widgets/dropdown.dart';

@RoutePage()
class OtherWalletScreen extends StatelessWidget {
  const OtherWalletScreen({
    super.key,
    @queryParam this.amount,
    @queryParam this.recipient,
    @queryParam this.reference,
  });

  final String? amount;
  final String? recipient;
  final String? reference;

  static const route = OtherWalletRoute.new;

  @override
  Widget build(BuildContext context) {
    final request = context.createUniversalRequest(
      amount: amount,
      receiver: recipient,
      reference: reference,
    );

    return request == null
        ? const SizedBox.shrink()
        : BlocProvider(
            create: (context) => UniversalPayBloc(
              context.read<UniversalPayRepository>(),
              request,
            ),
            child: PaymentRequestVerifier(
              paymentRequest: request,
              child: _Body(request),
            ),
          );
  }
}

class _Body extends StatefulWidget {
  const _Body(this.request);

  final SolanaPayRequest request;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
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
  Widget build(BuildContext context) =>
      BlocListener<UniversalPayBloc, UniversalPayState>(
        listenWhen: (prev, cur) => prev.expiresAt != cur.expiresAt,
        listener: (context, state) => _resetTimer(state.expiresAt),
        child: BlocBuilder<UniversalPayBloc, UniversalPayState>(
          builder: (context, state) => CpLoader(
            isLoading: state.processingState.isProcessing,
            child: PageWidget(
              statusWidget: TimelineStatus(widget.request),
              children: [
                const Text(
                  'You have a payment request.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.23,
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Payment Method',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                PaymentMethodDropdown(
                  current: state.selectedBlockchain,
                  onChanged: context.read<UniversalPayBloc>().changeBlockchain,
                ),
                const SizedBox(height: 32),
                const Text(
                  'Destination Address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                DestinationAddressWidget(
                  address: state.destinationEvmAddress,
                ),
                const SizedBox(height: 24),
                CountdownTimer(expiryDate: state.expiresAt ?? DateTime.now()),
                const SizedBox(height: 12),
                Text(
                  'Network Fee: ${state.fee ?? ''} USDC',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.23,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Total Amount: ${state.totalAmount ?? ''} USDC',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.23,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

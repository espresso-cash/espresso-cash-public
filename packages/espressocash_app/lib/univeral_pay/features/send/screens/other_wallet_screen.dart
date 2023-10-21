import 'package:auto_route/auto_route.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana_pay.dart';

import '../../../../l10n/l10n.dart';
import '../../../../ui/button.dart';
import '../../../../ui/loader.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';
import '../../../core/blockchain.dart';
import '../../../core/page.dart';
import '../../../core/request_helpers.dart';
import '../../../routes.gr.dart';
import '../../verifier/widgets/request_verifier.dart';
import '../../verifier/widgets/timeline_status.dart';
import '../data/repository.dart';
import '../service/universal_pay_bloc.dart';

@RoutePage()
class OtherWalletScreen extends StatelessWidget implements AutoRouteWrapper {
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
    final request = context.watch<SolanaPayRequest>();

    return PaymentRequestVerifier(
      paymentRequest: request,
      child: BlocBuilder<UniversalPayCubit, UniversalPayState>(
        builder: (context, state) => CpLoader(
          isLoading: state.processingState.isProcessing,
          child: PageWidget(
            statusWidget: TimelineStatus(request),
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
              _PaymentMethodDropdown(
                current: state.blockchain,
                onChanged: context.read<UniversalPayCubit>().changeBlockchain,
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
              _DestinationWidget(
                address: state.destinationAddress ?? '',
              ),
              const SizedBox(height: 32),
              Text(
                'Network Fee: ${state.blockchain.fee} USDC',
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

  @override
  Widget wrappedRoute(BuildContext context) {
    final request = context.createUniversalRequest(
      amount: amount,
      receiver: recipient,
      reference: reference,
    );

    return request != null
        ? Provider<SolanaPayRequest>.value(
            value: request,
            child: BlocProvider(
              create: (context) => UniversalPayCubit(
                context.read<UniversalPayRepository>(),
                request,
              ),
              child: this,
            ),
          )
        : const SizedBox.shrink();
  }
}

class _PaymentMethodDropdown extends StatelessWidget {
  const _PaymentMethodDropdown({
    required this.current,
    required this.onChanged,
  });

  final Blockchain current;
  final ValueSetter<Blockchain> onChanged;

  @override
  Widget build(BuildContext context) {
    final blockchains = Blockchain.values.where((e) => e != Blockchain.solana);

    return SizedBox(
      width: 325,
      child: DecoratedBox(
        decoration: const ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(63),
            ),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<Blockchain>(
            isExpanded: true,
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
            value: current,
            onChanged: (value) {
              if (value != null) {
                onChanged(value);
              }
            },
            selectedItemBuilder: (context) => blockchains
                .map<Widget>(
                  (value) => Center(
                    child: Text(
                      'With USDC on ${value.name}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
            items: blockchains
                .map<DropdownMenuItem<Blockchain>>(
                  (value) => DropdownMenuItem<Blockchain>(
                    value: value,
                    child: Text(value.name),
                  ),
                )
                .toList(),
            dropdownColor: Colors.black,
            icon: const Icon(
              Icons.expand_more,
              color: Colors.white,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
    );
  }
}

class _DestinationWidget extends StatelessWidget {
  const _DestinationWidget({
    required this.address,
  });

  final String address;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 410,
        height: 155,
        child: CpRoundedRectangle(
          padding: const EdgeInsets.all(24),
          backgroundColor: Colors.black,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: BarcodeWidget(
                  width: 100,
                  height: 100,
                  barcode: Barcode.qrCode(),
                  data: address,
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      address,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CpButton(
                        text: context.l10n.copy,
                        minWidth: 80,
                        onPressed: () {
                          final data = ClipboardData(text: address);
                          Clipboard.setData(data);
                          showClipboardSnackbar(context);
                        },
                        size: CpButtonSize.micro,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

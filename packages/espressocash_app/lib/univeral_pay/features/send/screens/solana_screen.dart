import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/page.dart';
import '../../../core/qr.dart';
import '../../../core/request_helpers.dart';
import '../../../routes.gr.dart';
import '../../verifier/widgets/request_verifier.dart';
import '../../verifier/widgets/timeline_status.dart';

@RoutePage()
class SolanaSendScreen extends StatelessWidget {
  const SolanaSendScreen({
    super.key,
    @queryParam this.amount,
    @queryParam this.recipient,
    @queryParam this.reference,
  });

  final String? amount;
  final String? recipient;
  final String? reference;

  static const route = SolanaSendRoute.new;

  @override
  Widget build(BuildContext context) {
    final request = context.createUniversalRequest(
      amount: amount,
      receiver: recipient,
      reference: reference,
    );

    return request != null
        ? PaymentRequestVerifier(
            paymentRequest: request,
            child: PageWidget(
              statusWidget: TimelineStatus(request),
              children: [
                const Text(
                  'You have a payment request in the amount of',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.23,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${request.amount ?? '0'} USDC',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 41,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 52),
                const Text(
                  'Scan This QR Code With Your Crypto Wallet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
                QrWidget(qrLink: Uri.parse(request.toUrl())),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}

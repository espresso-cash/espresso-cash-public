import 'package:flutter/material.dart';

import '../../core/page.dart';
import '../../core/qr.dart';

class SolanaSendScreen extends StatelessWidget {
  const SolanaSendScreen({
    super.key,
    required this.actionLink,
    required this.amount,
  });

  final Uri actionLink;
  final String amount;

  @override
  Widget build(BuildContext context) => PageWidget(
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
            '$amount USDC',
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
          QrWidget(qrLink: actionLink),
        ],
      );
}

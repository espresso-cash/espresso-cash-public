import 'package:flutter/material.dart';

import '../../../../ui/back_button.dart';
import '../../../core/landing_widget.dart';
import '../../../core/presentation/qr_code.dart';

class SolanaWalletScreen extends StatelessWidget {
  const SolanaWalletScreen({
    super.key,
    required this.actionLink,
    required this.title,
  });

  final Uri actionLink;
  final String title;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LandingDesktopWidget(
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
                const SizedBox.shrink(),
              ],
            ),
          ),
          content: Column(
            children: [
              const SizedBox(height: 40),
              QrWidget(
                size: 250,
                code: actionLink.toString(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Scan the QR code with your Solana wallet',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF2D2B2C),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
}

import 'package:flutter/material.dart';

import '../../../../l10n/l10n.dart';
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
          header: HeaderDesktop(
            title: title,
            showBackButton: true,
          ),
          content: Column(
            children: [
              const SizedBox(height: 40),
              QrWidget(
                size: 250,
                code: actionLink.toString(),
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.landingScanSolanaWallet,
                textAlign: TextAlign.center,
                style: const TextStyle(
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

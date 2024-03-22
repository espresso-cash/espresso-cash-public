import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';

import '../../../../l10n/l10n.dart';
import '../../../ui/desktop_page.dart';
import '../../../ui/qr_code.dart';
import '../widgets/invoice.dart';

class SolanaWalletScreen extends StatelessWidget {
  const SolanaWalletScreen({
    super.key,
    required this.request,
    required this.title,
  });

  final SolanaPayRequest request;
  final String title;

  @override
  Widget build(BuildContext context) => LandingDesktopPage(
        title: title,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            QrWidget(
              size: 250,
              code: request.toUrl(),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.scanSolanaWallet,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF2D2B2C),
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (request.reference?.first case final reference?) ...[
              const Spacer(),
              InvoiceWidget(address: reference.toBase58()),
            ],
          ],
        ),
      );
}

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:solana/solana.dart';

import '../../../ui/colors.dart';
import '../models/ambassador_referral.dart';
import '../widgets/ambassador_page.dart';

class ShareAmbassadorLinkScreen extends StatelessWidget {
  const ShareAmbassadorLinkScreen({super.key, required this.name, required this.address});

  final String name;
  final Ed25519HDPublicKey address;

  static void push(
    BuildContext context, {
    required String name,
    required Ed25519HDPublicKey address,
  }) => Navigator.of(context).push<void>(
    MaterialPageRoute(
      builder: (context) => ShareAmbassadorLinkScreen(name: name, address: address),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final referral = AmbassadorReferral(address: address);
    final uri = referral.toLink();

    return AmbassadorPage(
      name: name,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Center(
              child: BarcodeWidget(
                height: 220,
                barcode: Barcode.qrCode(),
                data: uri.toString(),
                padding: EdgeInsets.zero,
                color: CpColors.sandColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

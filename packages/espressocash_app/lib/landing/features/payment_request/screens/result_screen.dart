import 'package:flutter/material.dart';
import 'package:solana/solana_pay.dart';

import '../../../../gen/assets.gen.dart';
import '../../../core/landing_desktop.dart';
import '../widgets/invoice.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.request});
  final SolanaPayRequest request;

  @override
  Widget build(BuildContext context) => _DesktopView(request);
}

class _DesktopView extends StatelessWidget {
  const _DesktopView(this.request);

  final SolanaPayRequest request;

  @override
  Widget build(BuildContext context) => LandingDesktopPage(
        title: 'Thank you',
        subtitle: 'Your payment has been accepted.',
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Assets.landing.receipt.image(height: 87, width: 87),
            ),
            const Divider(color: borderColor),
            const Spacer(),
            const _Item(
              title: 'Status',
              value: 'Pending',
            ),
            const _Item(
              title: 'Amount paid',
              value: '23 USDC',
            ),
            const _Item(
              title: 'Network fee',
              value: '3.45 USDC',
            ),
            const _Item(
              title: 'Total',
              value: '26.45 USDC',
            ),
            if (request.reference?.first case final reference?) ...[
              const Spacer(),
              InvoiceWidget(address: reference.toBase58()),
            ],
          ],
        ),
      );
}

class _Item extends StatelessWidget {
  const _Item({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        constraints: const BoxConstraints(maxWidth: 400),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}

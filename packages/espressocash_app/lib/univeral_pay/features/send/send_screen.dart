import 'package:flutter/material.dart';

import '../../../ui/button.dart';
import '../../core/arrow.dart';
import '../../core/divider.dart';
import '../../core/page.dart';
import 'other_wallet_screen.dart';
import 'solana_screen.dart';

class SenderInitialScreen extends StatelessWidget {
  const SenderInitialScreen({super.key});

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
          const Text(
            '132 USDC',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 41,
              fontWeight: FontWeight.w700,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 40),
          CpButton(
            text: 'Pay With USDC on Solana',
            size: CpButtonSize.big,
            width: 350,
            trailing: const Arrow(),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => SolanaSendScreen(
                    amount: '132',
                    actionLink: Uri.parse('TESTTODO'),
                  ),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: DividerWidget(),
          ),
          CpButton(
            text: 'Other Payment Method',
            size: CpButtonSize.big,
            variant: CpButtonVariant.black,
            width: 350,
            trailing: const Arrow(
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => const OtherWalletScreen(),
                ),
              );
            },
          ),
        ],
      );
}

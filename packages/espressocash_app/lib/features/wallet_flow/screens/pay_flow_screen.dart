import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../routes.gr.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/theme.dart';

@RoutePage()
class PayFlowScreen extends StatelessWidget {
  const PayFlowScreen({
    super.key,
    required this.onLink,
    required this.onManual,
  });
  final VoidCallback onLink;
  final VoidCallback onManual;

  static const route = PayFlowRoute.new;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: Text('Transaction Method'.toUpperCase()),
          ),
          body: Column(
            children: [
              const SizedBox(height: 32),
              PayItem(
                title: 'Espresso Pay',
                subtitle:
                    'Send money to friends or family via any messaging platform.',
                buttonText: 'Using a Secure Link',
                onPressed: onLink,
                buttonTrailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const Divider(
                color: Color(0xff454243),
                thickness: 1.5,
              ),
              PayItem(
                title: 'Manual',
                subtitle:
                    'Pay a person or a business using their wallet address.',
                buttonText: 'Using a Wallet Address',
                onPressed: onManual,
                buttonTrailing: const Icon(
                  Icons.keyboard_arrow_right_outlined,
                  color: Colors.white,
                  size: 34,
                ),
              ),
            ],
          ),
        ),
      );
}

class PayItem extends StatelessWidget {
  const PayItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.buttonText,
    this.onPressed,
    this.buttonTrailing,
  });

  final String title;
  final String? subtitle;

  final String buttonText;
  final Widget? buttonTrailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 12),
            DecoratedBox(
              decoration: const ShapeDecoration(
                color: Colors.black,
                shape: StadiumBorder(),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                onTap: onPressed,
                title: Text(
                  buttonText,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: buttonTrailing,
              ),
            ),
            const SizedBox(height: 12),
            if (subtitle case final subtitle?)
              Padding(
                padding: const EdgeInsets.only(left: 24.0),
                child: Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF8F8F8F),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
          ],
        ),
      );
}

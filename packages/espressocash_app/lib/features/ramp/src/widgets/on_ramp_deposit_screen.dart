import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../di.dart';
import '../../../../l10n/l10n.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/button.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/rounded_rectangle.dart';
import '../../../../ui/snackbar.dart';
import '../../../../ui/theme.dart';
import '../../data/on_ramp_order_service.dart';
import 'countdown.dart';

class OnRampDepositScreen extends StatelessWidget {
  const OnRampDepositScreen({super.key, required this.order});

  final OnRampOrder order;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'ADD CASH',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            leading: CpBackButton(
              onPressed: () => context.router.popUntilRoot(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CountdownTimer(
                  expiryDate: order.transferExpiryDate ?? DateTime.now(),
                ),
              ),
            ],
            elevation: 0,
            shape: const Border(),
          ),
          body: CpContentPadding(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 16),
                const _InstructionItem(
                  index: 1,
                  text:
                      'Transfer money from your bank account to our local partner:',
                ),
                const SizedBox(height: 8),
                const _ItemWidget(
                  title: 'Amount to be transferred',
                  value: '400,000 NGN',
                ),
                const SizedBox(height: 24),
                _ItemWidget(
                  title: '${order.bankName ?? ''} Account',
                  value: order.bankAccount ?? '',
                ),
                const SizedBox(height: 16),
                const _InstructionItem(
                  index: 2,
                  text:
                      'Once money has been transferred, return to Espresso Cash and continue below.',
                ),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.only(left: 42),
                  child: Text(
                    'You will receive: 498.44 USDC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.23,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 42),
                  child: Text(
                    'Funds must be sent from your personal account. Any funds sent through an account that does not match your identification details will be reserved.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: CpButton(
                width: double.infinity,
                onPressed: () => sl<OnRampOrderService>().deposit(order.id),
                text: 'Continue',
              ),
            ),
          ),
        ),
      );
}

class _InstructionItem extends StatelessWidget {
  const _InstructionItem({
    required this.text,
    required this.index,
  });
  final int index;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: CpColors.yellowColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$index',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.23,
                ),
              ),
            ),
          ),
        ],
      );
}

class _ItemWidget extends StatelessWidget {
  const _ItemWidget({
    required this.value,
    required this.title,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.23,
            ),
          ),
          const SizedBox(height: 12),
          CpRoundedRectangle(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            backgroundColor: Colors.black,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      value,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CpButton(
                    text: context.l10n.copy,
                    minWidth: 80,
                    onPressed: () {
                      final data = ClipboardData(text: value);
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
      );
}

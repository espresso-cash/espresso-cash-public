import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../di.dart';
import '../../../../ui/app_bar.dart';
import '../../../../ui/back_button.dart';
import '../../../../ui/button.dart';
import '../../../../ui/content_padding.dart';
import '../../../../ui/theme.dart';
import '../../data/on_ramp_order_service.dart';

class OnRampDepositScreen extends StatelessWidget {
  const OnRampDepositScreen({super.key, required this.order});

  final OnRampOrder order;

  @override
  Widget build(BuildContext context) => CpTheme.black(
        child: Scaffold(
          appBar: CpAppBar(
            title: const Text(
              'DEPOSIT',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
              ),
            ),
            leading: CpBackButton(
              onPressed: () => context.router.popUntilRoot(),
            ),
          ),
          body: CpContentPadding(
            child: Column(
              children: [
                Text(order.bankName ?? ''),
                Text(order.bankAccount ?? ''),
                Text(order.amount.toString()),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CpButton(
                    width: double.infinity,
                    onPressed: () => sl<OnRampOrderService>().deposit(order.id),
                    text: 'I have deposited',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}

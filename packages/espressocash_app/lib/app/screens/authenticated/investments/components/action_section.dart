import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/currency.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../features/ramp/widgets/ramp_buttons.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
    required this.padding,
  }) : super(key: key);

  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    const token = Token.usdc;
    final isZeroAmount = context
        .watchUserFiatBalance(token)
        .ifNull(() => Amount.zero(currency: Currency.usd))
        .let((it) => it.decimal != Decimal.zero);

    return Column(
      children: [
        if (!isZeroAmount) const Divider(color: CpColors.darkDividerColor),
        Expanded(
          child: Padding(
            padding: padding,
            child: isZeroAmount ? const _NoBalance() : const _Actions(),
          ),
        )
      ],
    );
  }
}

class _NoBalance extends StatelessWidget {
  const _NoBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.l10n.fundYourAccount,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const AddCashButton(),
          const SizedBox(height: 24),
        ],
      );
}

class _Actions extends StatelessWidget {
  const _Actions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.investmentHeaderButtonsTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CpButton(
                text: context.l10n.sendMoney,
                onPressed: () =>
                    context.router.navigate(const WalletFlowRoute()),
              ),
              const SizedBox(width: 8),
              const AddCashButton(),
              const SizedBox(width: 8),
              const CashOutButton(),
            ],
          ),
          const SizedBox(height: 24),
        ],
      );
}

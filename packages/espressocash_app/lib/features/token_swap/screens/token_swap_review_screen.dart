import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/bottom_button.dart';
import '../../../ui/colors.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';

class TokenSwapReviewScreen extends StatelessWidget {
  const TokenSwapReviewScreen({
    super.key,
    required this.payAmount,
    required this.payToken,
    required this.receiveAmount,
    required this.receiveToken,
  });

  static Future<Decimal?> push(
    BuildContext context, {
    required Token payToken,
    required String payAmount,
    required Token receiveToken,
    required String receiveAmount,
  }) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TokenSwapReviewScreen(
            payAmount: payAmount,
            payToken: payToken,
            receiveAmount: receiveAmount,
            receiveToken: receiveToken,
          ),
        ),
      );

  final String payAmount;
  final Token payToken;
  final String receiveAmount;
  final Token receiveToken;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: CpColors.deepGreyColor,
        appBar: CpAppBar(
          title: Text(context.l10n.reviewSwap.toUpperCase()),
        ),
        body: Stack(
          children: [
            SafeArea(
              minimum: const EdgeInsets.only(bottom: 40),
              child: LayoutBuilder(
                builder: (
                  BuildContext context,
                  BoxConstraints viewportConstraints,
                ) =>
                    DecoratedBox(
                  decoration: const BoxDecoration(),
                  child: Column(
                    children: [
                      _TokensInfo(
                        payToken: payToken,
                        payAmount: payAmount,
                        payUsdAmount: r'$3,600.820129',
                        receiveToken: receiveToken,
                        receiveAmount: receiveAmount,
                        receiveUsdAmount: r'$3,196.0182',
                      ),
                      const SizedBox(height: 36),
                      const _SwapInfo(
                        provider: 'provider',
                        bestPrice: 'bestPrice',
                        fees: 'fees',
                        slippage: 'slippage',
                        priceImpact: 'priceImpact',
                      ),
                      const Spacer(),
                      CpBottomButton(
                        text: context.l10n.swap,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _TokensInfo extends StatelessWidget {
  const _TokensInfo({
    required this.payToken,
    required this.payAmount,
    required this.payUsdAmount,
    required this.receiveToken,
    required this.receiveAmount,
    required this.receiveUsdAmount,
  });

  final Token payToken;
  final String payAmount;
  final String payUsdAmount;
  final Token receiveToken;
  final String receiveAmount;
  final String receiveUsdAmount;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          _TokenRow(
            label: 'You Pay',
            token: payToken,
            amount: payAmount,
            usdAmount: payUsdAmount,
          ),
          const Divider(
            color: CpColors.backgroundAccentColor,
            thickness: 1,
          ),
          _TokenRow(
            label: 'You Receive',
            token: receiveToken,
            amount: receiveAmount,
            usdAmount: receiveUsdAmount,
          ),
        ],
      );
}

class _TokenRow extends StatelessWidget {
  const _TokenRow({
    required this.label,
    required this.token,
    required this.amount,
    required this.usdAmount,
  });

  final String label;
  final Token token;
  final String amount;
  final String usdAmount;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
              ),
            ),
            const SizedBox(width: 12),
            TokenIcon(token: token, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    amount,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    usdAmount,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff999999),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

class _SwapInfo extends StatelessWidget {
  const _SwapInfo({
    required this.provider,
    required this.bestPrice,
    required this.fees,
    required this.slippage,
    required this.priceImpact,
  });

  final String provider;
  final String bestPrice;
  final String fees;
  final String slippage;
  final String priceImpact;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 22),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 28),
        decoration: const ShapeDecoration(
          color: CpColors.blackGreyColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(28)),
          ),
        ),
        child: Column(
          children: [
            _InfoItem(
              label: 'Provider',
              value: provider,
            ),
            const SizedBox(height: 6),
            _InfoItem(
              label: 'Best Price',
              value: bestPrice,
            ),
            const SizedBox(height: 6),
            _InfoItem(
              label: context.l10n.fees,
              value: fees,
            ),
            const SizedBox(height: 6),
            _InfoItem(
              label: 'Slippage',
              value: slippage,
            ),
            const SizedBox(height: 6),
            _InfoItem(
              label: 'Price Impact',
              value: priceImpact,
            ),
          ],
        ),
      );
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
  });
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff999999),
              ),
            ),
          ],
        ),
      );
}

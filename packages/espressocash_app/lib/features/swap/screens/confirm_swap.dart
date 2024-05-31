import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../../../ui/app_bar.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
import '../widgets/divider.dart';

class ConfirmSwapScreen extends StatelessWidget {
  const ConfirmSwapScreen({
    super.key,
    required this.inputToken,
    required this.outputToken,
  });

  final Token inputToken;
  final Token outputToken;

  static void push(
    BuildContext context, {
    required Token inputToken,
    required Token outputToken,
  }) =>
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => ConfirmSwapScreen(
            inputToken: inputToken,
            outputToken: outputToken,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return CpTheme.black(
      child: Scaffold(
        appBar:
            CpAppBar(title: Text(context.l10n.swapReviewTitle.toUpperCase())),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              _TokenRow(
                token: inputToken,
                title: context.l10n.swapInputLabel,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: EcDivider(),
              ),
              _TokenRow(
                token: outputToken,
                title: context.l10n.swapOutputLabel,
              ),
              const SizedBox(height: 16),
              const _SwapInfo(),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CpButton(
                  text: 'Swap',
                  minWidth: width,
                  onPressed: () {},
                  size: CpButtonSize.big,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SwapInfo extends StatelessWidget {
  const _SwapInfo({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            DecoratedBox(
              decoration: const BoxDecoration(
                color: CpColors.darkBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  children: [
                    _InfoItem(
                      title: 'Provider',
                      value: 'Raydium CLMM + Meteora DL..' * 2,
                    ),
                    const _InfoItem(
                      title: 'Best Price',
                      value: '1 SOL = 161.59 USDC',
                    ),
                    const _InfoItem(
                      title: 'Fees',
                      value: r'$0.017',
                    ),
                    const _InfoItem(
                      title: 'Slippage',
                      value: r'$0.017',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.swapFeeLabel('0.85%'),
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xff999999),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff999999),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
}

class _TokenRow extends StatelessWidget {
  const _TokenRow({
    super.key,
    required this.token,
    required this.title,
  });
  final Token token;
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ListTile(
                leading: TokenIcon(token: token, size: 42),
                title: Text(
                  '100.0 ${token.symbol}',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: const Text(
                  r'$100.0',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

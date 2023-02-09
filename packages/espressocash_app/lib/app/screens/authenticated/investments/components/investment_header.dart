import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/currency.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../features/ramp/widgets/ramp_buttons.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/token_icon.dart';

const _token = Token.usdc;

class InvestmentHeader extends StatelessWidget {
  const InvestmentHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 280,
        decoration: const BoxDecoration(color: CpColors.darkBackground),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Flexible(
              flex: 4,
              child: _Balance(),
            ),
            Flexible(
              flex: 5,
              child: _Buttons(),
            ),
          ],
        ),
      );
}

class _Balance extends StatefulWidget {
  const _Balance({Key? key}) : super(key: key);

  @override
  State<_Balance> createState() => _BalanceState();
}

class _BalanceState extends State<_Balance> {
  bool _showMore = false;

  void _toggleInfo() => setState(() => _showMore = !_showMore);

  @override
  Widget build(BuildContext context) {
    final info = _Info(onClose: _toggleInfo);
    final displayBalance = _DisplayBalance(onInfo: _toggleInfo);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _showMore ? info : displayBalance,
    );
  }
}

class _DisplayBalance extends StatelessWidget {
  const _DisplayBalance({
    Key? key,
    required this.onInfo,
  }) : super(key: key);

  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) {
    final amount = context.watchUsdcBalance();
    final formattedAmount = amount.format(
      DeviceLocale.localeOf(context),
      roundInteger: amount.isZeroAmount,
    );

    final headline = RichText(
      text: TextSpan(
        text: context.l10n.cryptoCashBalance,
        style: const TextStyle(
          fontSize: 21,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: onInfo,
              child: RichText(
                text: TextSpan(
                  text: context.l10n.inUsdc,
                  style: const TextStyle(
                    fontSize: 21,
                    color: CpColors.yellowColor,
                    fontWeight: FontWeight.w500,
                  ),
                  children: const [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: _InfoIcon(size: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final balance = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: FittedBox(
            child: Text(
              formattedAmount,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        const CpTokenIcon(token: _token, size: 30),
        const SizedBox(width: 8),
        if (amount.isZeroAmount)
          Flexible(
            flex: 5,
            child: Text(
              context.l10n.fundYourAccount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 24, top: 16, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          headline,
          const Spacer(),
          balance,
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CloseButton(color: Colors.white, onPressed: onClose),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _InfoIcon(size: 36),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    context.l10n.usdcInfo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: size,
        child: DecoratedBox(
          decoration: const ShapeDecoration(
            color: CpColors.yellowColor,
            shape: CircleBorder(),
          ),
          child: Padding(
            padding: EdgeInsets.all(size / 6),
            child: Assets.icons.info.svg(
              color: CpColors.darkBackground,
            ),
          ),
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isZeroAmount = context.watchUsdcBalance().isZeroAmount;

    if (isZeroAmount) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [AddCashButton()],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: CpColors.darkDividerColor),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Text(
            context.l10n.investmentHeaderButtonsTitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            children: [
              Flexible(
                child: CpButton(
                  text: context.l10n.sendMoney,
                  onPressed: () =>
                      context.router.navigate(const WalletFlowRoute()),
                ),
              ),
              const SizedBox(width: 8),
              const AddCashButton(),
              const SizedBox(width: 8),
              const CashOutButton(),
            ],
          ),
        )
      ],
    );
  }
}

extension on Amount {
  bool get isZeroAmount => decimal == Decimal.zero;
}

extension on BuildContext {
  Amount watchUsdcBalance() => watchUserFiatBalance(_token)
      .ifNull(() => Amount.zero(currency: Currency.usd));
}

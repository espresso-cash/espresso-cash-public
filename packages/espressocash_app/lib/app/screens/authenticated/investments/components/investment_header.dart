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
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/button.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/info_icon.dart';
import '../../../../../ui/info_widget.dart';
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
            Expanded(
              child: _Balance(),
            ),
            Expanded(
              child: _Buttons(),
            ),
          ],
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isZeroAmount = context.watchUsdcBalance().isZero;

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Calculated using the smallest value of screen width and font
              // size that does not overflow the button
              const minimumWidthFactor = 0.038;
              final maxFontSize = constraints.maxWidth * minimumWidthFactor;

              return Row(
                children: [
                  Flexible(
                    child: CpButton(
                      minWidth: 250,
                      maxFontSize: maxFontSize,
                      text: context.l10n.sendMoney,
                      onPressed: () =>
                          context.router.navigate(const WalletFlowRoute()),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AddCashButton(
                    maxFontSize: maxFontSize,
                  ),
                  const SizedBox(width: 8),
                  CashOutButton(
                    maxFontSize: maxFontSize,
                  ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
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
  Widget build(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _showMore
            ? _Info(onClose: _toggleInfo)
            : Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _Headline(onInfo: _toggleInfo),
                    const Spacer(),
                    const _Amount(),
                  ],
                ),
              ),
      );
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
            child: CpInfoWidget(
              message: Text(
                context.l10n.usdcInfo,
                style: const TextStyle(color: Colors.white),
              ),
              variant: CpInfoVariant.dark,
            ),
          )
        ],
      );
}

class _Amount extends StatelessWidget {
  const _Amount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final amount = context.watchUsdcBalance();
    final formattedAmount = amount.format(
      DeviceLocale.localeOf(context),
      roundInteger: amount.isZero,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FittedBox(
          child: Text(
            formattedAmount,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ).let((it) => amount.isZero ? it : Flexible(child: it)),
        const SizedBox(width: 8),
        const CpTokenIcon(token: _token, size: 30),
        const SizedBox(width: 8),
        if (amount.isZero)
          Flexible(
            child: Text(
              context.l10n.fundYourAccount,
              style: const TextStyle(
                fontSize: 14.5,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({
    Key? key,
    required this.onInfo,
  }) : super(key: key);

  final VoidCallback onInfo;

  @override
  Widget build(BuildContext context) => RichText(
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
                        child: CircleAvatar(
                          maxRadius: 10,
                          backgroundColor: CpColors.yellowColor,
                          child: Padding(
                            padding: EdgeInsets.all(4.0),
                            child: CpInfoIcon(
                              iconColor: CpColors.darkBackground,
                            ),
                          ),
                        ),
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

extension on Amount {
  bool get isZero => decimal == Decimal.zero;
}

extension on BuildContext {
  Amount watchUsdcBalance() => watchUserFiatBalance(_token)
      .ifNull(() => Amount.zero(currency: Currency.usd));
}

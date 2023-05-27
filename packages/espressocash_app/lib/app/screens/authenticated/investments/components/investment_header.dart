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
import '../../../../../ui/info_icon.dart';
import '../../../../../ui/info_widget.dart';
import '../../../../../ui/token_icon.dart';

class InvestmentHeader extends StatelessWidget {
  const InvestmentHeader({super.key});

  @override
  Widget build(BuildContext context) => const DecoratedBox(
        decoration: BoxDecoration(color: CpColors.darkBackground),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _Balance(),
            _Buttons(),
          ],
        ),
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) {
    final isZeroAmount = context.watchUsdcBalance().isZero;

    return isZeroAmount
        ? const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [AddCashButton()],
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: CpColors.darkDividerColor),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Row(
                  children: [
                    Flexible(
                      child: CpButton(
                        minWidth: 250,
                        size: CpButtonSize.wide,
                        text: context.l10n.sendMoney,
                        onPressed: () =>
                            context.router.navigate(const WalletFlowRoute()),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const AddCashButton(size: CpButtonSize.wide),
                    const SizedBox(width: 8),
                    const CashOutButton(size: CpButtonSize.wide),
                  ],
                ),
              )
            ],
          );
  }
}

class _Balance extends StatefulWidget {
  const _Balance();

  @override
  State<_Balance> createState() => _BalanceState();
}

class _BalanceState extends State<_Balance> {
  bool _showMore = false;

  void _toggleInfo() => setState(() => _showMore = !_showMore);

  @override
  Widget build(BuildContext context) => _HeaderSwitcher(
        first: Padding(
          padding: const EdgeInsets.only(left: 24, top: 16, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Headline(onInfo: _toggleInfo),
              const SizedBox(height: 8),
              const _Amount(),
            ],
          ),
        ),
        second: _Info(onClose: _toggleInfo),
        showMore: _showMore,
      );
}

class _Info extends StatelessWidget {
  const _Info({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Assets.icons.closeButtonIcon.svg(color: Colors.white),
              onPressed: onClose,
            ),
          ),
          CpInfoWidget(
            message: Text(
              context.l10n.usdcInfo,
              style: const TextStyle(color: Colors.white),
            ),
            variant: CpInfoVariant.dark,
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
        ],
      );
}

class _Amount extends StatelessWidget {
  const _Amount();

  @override
  Widget build(BuildContext context) {
    final amount = context.watchUsdcBalance();
    final formattedAmount = amount.format(
      DeviceLocale.localeOf(context),
      roundInteger: amount.isZero,
    );

    return GestureDetector(
      onTap: () => context.router.push(TokenDetailsRoute(token: Token.usdc)),
      child: Row(
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
          const CpTokenIcon(token: Token.usdc, size: 30),
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
      ),
    );
  }
}

class _Headline extends StatelessWidget {
  const _Headline({required this.onInfo});

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
  Amount watchUsdcBalance() => watchUserFiatBalance(Token.usdc)
      .ifNull(() => Amount.zero(currency: Currency.usd));
}

class _HeaderSwitcher extends StatefulWidget {
  const _HeaderSwitcher({
    required this.first,
    required this.second,
    required this.showMore,
  });

  final Widget first;
  final Widget second;
  final bool showMore;

  @override
  State<_HeaderSwitcher> createState() => _HeaderSwitcherState();
}

class _HeaderSwitcherState extends State<_HeaderSwitcher> {
  double? _firstChildHeight;

  @override
  void didUpdateWidget(covariant _HeaderSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    _firstChildHeight = null;
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (_firstChildHeight == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              setState(() {
                _firstChildHeight = context.size?.height;
              });
            });
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: !widget.showMore
                ? widget.first
                : SizedBox(
                    key: const ValueKey('second'),
                    height: _firstChildHeight,
                    child: widget.second,
                  ),
          );
        },
      );
}

import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/currency.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/info_icon.dart';
import '../../../../../ui/token_icon.dart';

class BalanceSection extends StatefulWidget {
  const BalanceSection({
    Key? key,
    required this.padding,
  }) : super(key: key);

  final EdgeInsets padding;

  @override
  State<BalanceSection> createState() => BalanceSectionState();
}

class BalanceSectionState extends State<BalanceSection> {
  bool _showMore = false;

  void _toggleInfo() => setState(() => _showMore = !_showMore);

  @override
  Widget build(BuildContext context) => AnimatedCrossFade(
        crossFadeState:
            _showMore ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
        firstChild: _Balance(
          onInfoPressed: _toggleInfo,
          padding: widget.padding,
        ),
        secondChild: _Info(
          onClosePressed: _toggleInfo,
          padding: widget.padding,
        ),
        layoutBuilder: _crossFadeBuilder,
      );
}

class _Balance extends StatelessWidget {
  const _Balance({
    Key? key,
    required this.onInfoPressed,
    required this.padding,
  }) : super(key: key);

  final VoidCallback onInfoPressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    const token = Token.usdc;
    final locale = DeviceLocale.localeOf(context);
    final formattedAmount = context
        .watchUserFiatBalance(token)
        .ifNull(() => Amount.zero(currency: Currency.usd))
        .let((it) => it.format(locale));

    final clickable = GestureDetector(
      onTap: onInfoPressed,
      child: Text.rich(
        TextSpan(
          text: context.l10n.inUsdc,
          children: const [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: SizedBox.square(
                dimension: 18,
                child: _InfoIcon(),
              ),
            )
          ],
        ),
        style: _baseStyle.copyWith(color: CpColors.yellowColor),
      ),
    );

    return Center(
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: FittedBox(
                child: Text.rich(
                  TextSpan(
                    text: context.l10n.cryptoCashBalance,
                    children: [
                      WidgetSpan(child: clickable),
                    ],
                  ),
                  style: _baseStyle,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        formattedAmount,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const CpTokenIcon(token: token, size: 36),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    Key? key,
    required this.onClosePressed,
    required this.padding,
  }) : super(key: key);

  final VoidCallback onClosePressed;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // TODO(rhbrunetto): Fix it, wrong icon style
          CloseButton(onPressed: onClosePressed, color: Colors.white),
          Padding(
            padding: padding,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox.square(
                  dimension: 28,
                  child: _InfoIcon(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    context.l10n.usdcInfo,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      );
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon();

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(2),
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: CpColors.yellowColor,
        ),
        child: const CpInfoIcon(iconColor: CpColors.darkBackground),
      );
}

const _baseStyle = TextStyle(
  color: Colors.white,
  fontSize: 22,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.2,
);

Widget _crossFadeBuilder(
  Widget topChild,
  Key topChildKey,
  Widget bottomChild,
  Key bottomChildKey,
) =>
    Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Positioned(
          key: bottomChildKey,
          left: 0.0,
          top: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: bottomChild,
        ),
        Positioned(
          key: topChildKey,
          child: topChild,
        ),
      ],
    );

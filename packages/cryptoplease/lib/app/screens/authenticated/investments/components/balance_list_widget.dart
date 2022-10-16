import 'package:cryptoplease/app/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/app/ui/colors.dart';
import 'package:cryptoplease/app/ui/empty_message_widget.dart';
import 'package:cryptoplease/app/ui/headered_list/content.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BalanceListWidget extends StatelessWidget {
  const BalanceListWidget({
    Key? key,
    required this.tokens,
    required this.isLoading,
    required this.emptyWidget,
  }) : super(key: key);

  final Iterable<Token> tokens;
  final bool isLoading;
  final Widget emptyWidget;

  @override
  Widget build(BuildContext context) => CpHeaderedListContent(
        padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
        itemCount: tokens.length,
        itemBuilder: (context, index) => _BalanceItem(
          token: tokens.elementAt(index),
        ),
        emptyWidget: isLoading
            ? CpEmptyMessageWidget(message: context.l10n.loading)
            : emptyWidget,
        showDivider: false,
      );
}

class _BalanceItem extends StatelessWidget {
  const _BalanceItem({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final fiatAmount = context.watchUserFiatBalance(token);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          decoration: const BoxDecoration(
            color: CpColors.yellowColor,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TokenIcon(token: token, size: 35),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  token.name,
                  style: _titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              _AmountDisplay(fiatAmount?.format(locale) ?? '-'),
            ],
          ),
        ),
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 16.5,
  color: Colors.black,
);

class _AmountDisplay extends StatelessWidget {
  const _AmountDisplay(
    this.amount, {
    Key? key,
  }) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 115,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 18,
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: CpColors.darkBackground,
          ),
          child: Center(
            widthFactor: 1,
            child: Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
          ),
        ),
      );
}

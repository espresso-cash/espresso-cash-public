import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/token_icon.dart';
import '../../../core/amount.dart';
import '../../../core/presentation/value_stream_builder.dart';
import '../../../di.dart';
import '../../conversion_rates/services/watch_user_fiat_balance.dart';
import '../../token_details/screens/token_details_screen.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key, required this.tokens});

  final IList<Token> tokens;

  @override
  Widget build(BuildContext context) => MultiSliver(
        children: [
          if (tokens.isNotEmpty)
            SliverList(
              delegate: SliverChildListDelegate(
                tokens.map((token) => _BalanceItem(token: token)).toList(),
              ),
            ),
        ],
      );
}

class _BalanceItem extends StatelessWidget {
  const _BalanceItem({required this.token});

  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    return ValueStreamBuilder<Amount?>(
      create: () => sl<WatchUserFiatBalance>().call(token),
      builder: (context, fiatAmount) => Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () =>
              context.router.push(TokenDetailsScreen.route(token: token)),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
            decoration: const BoxDecoration(
              color: CpColors.yellowColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CpTokenIcon(token: token, size: 36),
                const SizedBox(width: 14),
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
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15.0,
  color: CpColors.menuPrimaryTextColor,
);

class _AmountDisplay extends StatelessWidget {
  const _AmountDisplay(this.amount);

  final String amount;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 95,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
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

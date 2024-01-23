import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../core/amount.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/value_stream_builder.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/button.dart';
import '../../../ui/colors.dart';
import '../../conversion_rates/services/watch_user_fiat_balance.dart';
import '../../token_details/screens/token_details_screen.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';
import '../screens/investments_screen.dart';
import '../services/watch_investments.dart';
import 'home_widget.dart';

const int _maxTokens = 3;

class PortfolioTile extends StatelessWidget {
  const PortfolioTile({
    super.key,
    required this.balance,
    required this.displayEmptyBalances,
  });

  final Amount balance;
  final bool displayEmptyBalances;

  @override
  Widget build(BuildContext context) => HomeTile(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      context.l10n.cryptoInvestments,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.17,
                        color: CpColors.menuPrimaryTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        balance.format(DeviceLocale.localeOf(context)),
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  color: CpColors.menuPrimaryTextColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0.17,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _PortfolioWidget(displayEmptyBalances: displayEmptyBalances),
            const SizedBox(height: 8),
            // TODO(KB): Check if needed
            // ignore: avoid-single-child-column-or-row
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CpButton(
                  text: context.l10n.recentActivitySeeAll,
                  size: CpButtonSize.micro,
                  variant: CpButtonVariant.black,
                  onPressed: () =>
                      context.router.push(InvestmentsScreen.route()),
                ),
              ],
            ),
          ],
        ),
      );
}

class _PortfolioWidget extends StatelessWidget {
  const _PortfolioWidget({required this.displayEmptyBalances});

  final bool displayEmptyBalances;

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<IList<Token>>(
        create: () => (
          sl<WatchInvestments>()
              .call(displayEmptyBalances: displayEmptyBalances),
          const IListConst([]),
        ),
        builder: (context, data) {
          final tokens = data.take(_maxTokens);

          final children = tokens
              .map((token) => _BalanceItem(token: token))
              .expand(
                (widget) => [
                  widget,
                  const _Divider(),
                ],
              )
              .toList();

          if (data.isNotEmpty) {
            children.removeLast();
          }

          return _Card(
            child: Column(children: children),
          );
        },
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
        child: ListTile(
          onTap: () =>
              context.router.push(TokenDetailsScreen.route(token: token)),
          leading: TokenIcon(token: token, size: 36),
          title: Text(
            token.name,
            style: const TextStyle(
              color: Color(0xFF2D2B2C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(
            fiatAmount?.format(locale) ?? '-',
            style: const TextStyle(
              color: Color(0xFF2D2B2C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: const ShapeDecoration(
          color: Color(0xFFFBC728),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
        ),
        child: child,
      );
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) => const Divider(
        color: Color(0xFFF4BF1D),
        height: 6,
        thickness: 4,
        indent: 8,
        endIndent: 8,
      );
}

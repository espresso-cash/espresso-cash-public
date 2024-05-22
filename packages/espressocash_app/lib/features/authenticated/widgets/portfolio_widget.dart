import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/home_tile.dart';
import '../../../ui/value_stream_builder.dart';
import '../../balances/data/token_balance_repository.dart';
import '../../conversion_rates/services/watch_token_fiat_balance.dart';
import '../../conversion_rates/services/watch_token_total_balance.dart';
import '../../conversion_rates/widgets/extensions.dart';
import '../../currency/models/amount.dart';
import '../../investments/services/watch_investments.dart';
import '../../tokens/token.dart';
import '../../tokens/widgets/token_icon.dart';

class PortfolioWidget extends StatelessWidget {
  const PortfolioWidget({super.key});

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<Amount>(
        create: () => sl<WatchTotalTokenFiatBalance>().call(),
        builder: (context, balance) {
          final hasNoInvestments = balance.decimal == Decimal.zero;

          return hasNoInvestments
              ? const SizedBox.shrink()
              : PortfolioTile(balance: balance);
        },
      );
}

class PortfolioTile extends StatelessWidget {
  const PortfolioTile({super.key, required this.balance});

  final Amount balance;

  @override
  Widget build(BuildContext context) => HomeTile(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
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
                      context.l10n.cryptoPortfolio,
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
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const _PortfolioWidget(),
          ],
        ),
      );
}

class _PortfolioWidget extends StatelessWidget {
  const _PortfolioWidget();

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<IList<Token>>(
        create: () => (
          sl<WatchInvestments>().call(),
          const IListConst([]),
        ),
        builder: (context, data) {
          final tokens = data;

          final children = tokens
              .map(
                (token) => _TokenItem(
                  key: ValueKey(token),
                  token: token,
                  amount: sl<TokenBalancesRepository>().read(token),
                ),
              )
              .toList();

          // return _Card(
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     itemBuilder: (context, index) {
          //       final token = tokens[index];

          //       return _TokenItem(
          //         key: ValueKey(token),
          //         token: token,
          //         amount: sl<TokensRepository>().read(token),
          //       );
          //     },
          //     itemCount: tokens.length,
          //   ),
          // );

          return _Card(
            child: Column(
              children: children,
            ),
          );
        },
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem({super.key, required this.token, required this.amount});

  final Token token;
  final CryptoAmount amount;

  static const double _iconSize = 36.0;

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<Amount?>(
        create: () => sl<WatchTokenFiatBalance>().call(token),
        builder: (context, fiatAmount) => Material(
          key: key,
          color: Colors.transparent,
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            minLeadingWidth: 0,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(_iconSize / 2),
              child: ColoredBox(
                color: CpColors.darkBackground,
                child: TokenIcon(token: token, size: _iconSize),
              ),
            ),
            title: Text(
              token.name,
              style: const TextStyle(
                color: Color(0xFF34393C),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fiatAmount?.format(context.locale) ?? '-',
                  style: const TextStyle(
                    color: Color(0xFF3C3434),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  amount.format(context.locale),
                  style: const TextStyle(
                    color: Color(0xFF34393C),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            // isThreeLine: true,
          ),
        ),
      );
}

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(28),
            ),
          ),
        ),
        child: child,
      );
}

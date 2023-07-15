import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../core/amount.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/presentation/value_stream_builder.dart';
import '../../../core/tokens/token.dart';
import '../../../core/user_preferences.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/services/watch_user_total_fiat_balance.dart';
import '../data/repository.dart';
import '../services/watch_investments.dart';
import 'portfolio_widget.dart';

class CryptoInvestments extends StatelessWidget {
  const CryptoInvestments({super.key});

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<Amount>(
        create: () => sl<WatchUserTotalFiatBalance>().call(
          context.read<UserPreferences>().fiatCurrency,
          ignoreTokens: [Token.usdc],
        ),
        builder: (context, balance) {
          final displayEmptyBalances = context
              .watch<InvestmentSettingsRepository>()
              .displayEmptyBalances;

          return balance.decimal == Decimal.zero && !displayEmptyBalances
              ? const SliverToBoxAdapter(child: SizedBox.shrink())
              : MultiSliver(
                  children: [
                    _Header(balance),
                    const SizedBox(height: 15),
                    _Portfolio(displayEmptyBalances: displayEmptyBalances),
                  ],
                );
        },
      );
}

class _Portfolio extends StatelessWidget {
  const _Portfolio({required this.displayEmptyBalances});

  final bool displayEmptyBalances;

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<IList<Token>>(
        create: () => (
          sl<WatchInvestments>()
              .call(displayEmptyBalances: displayEmptyBalances),
          const IListConst([]),
        ),
        builder: (context, tokens) => PortfolioWidget(tokens: tokens),
      );
}

class _Header extends StatelessWidget {
  const _Header(this.balance);

  final Amount balance;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Text(
              context.l10n.cryptoInvestments,
              style: dashboardSectionTitleTextStyle,
              maxLines: 2,
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: FittedBox(
              child: Text(
                balance.format(DeviceLocale.localeOf(context)),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: CpColors.menuPrimaryTextColor,
                    ),
              ),
            ),
          ),
        ],
      );
}

import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../core/balances/bl/balances_bloc.dart';
import '../../../core/balances/presentation/watch_balance.dart';
import '../../../core/presentation/format_amount.dart';
import '../../../core/tokens/token.dart';
import '../../../core/user_preferences.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/colors.dart';
import '../../../ui/theme.dart';
import '../src/data/repository.dart';
import 'portfolio_widget.dart';

class CryptoInvestments extends StatelessWidget {
  const CryptoInvestments({super.key});

  static final Decimal _minimumUsdAmount = Decimal.parse('0.01');

  @override
  Widget build(BuildContext context) => MultiSliver(
        children: [
          const _Header(),
          const SizedBox(height: 15),
          BlocBuilder<BalancesBloc, BalancesState>(
            builder: (context, state) {
              final displayEmptyBalances = context
                  .watch<InvestmentSettingsRepository>()
                  .displayEmptyBalances;

              final tokens = state.userTokens.where((e) => e != Token.usdc).let(
                    (tokens) => displayEmptyBalances
                        ? tokens
                        : tokens.where((token) {
                            final Decimal balance =
                                context.watchUserFiatBalance(token)?.decimal ??
                                    Decimal.zero;

                            return balance >= _minimumUsdAmount;
                          }),
                  );

              return PortfolioWidget(tokens: IList(tokens));
            },
          ),
        ],
      );
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final balance = context.watchUserTotalFiatBalance(
      context.watch<UserPreferences>().fiatCurrency,
      ignoreTokens: [Token.usdc],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.cryptoInvestments,
          style: dashboardSectionTitleTextStyle,
        ),
        Text(
          balance.format(DeviceLocale.localeOf(context)),
          style: Theme.of(context).textTheme.headline2?.copyWith(
                fontSize: 50,
                fontWeight: FontWeight.w700,
                color: CpColors.menuPrimaryTextColor,
              ),
        ),
      ],
    );
  }
}

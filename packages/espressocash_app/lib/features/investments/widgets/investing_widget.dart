import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/amount.dart';
import '../../../core/presentation/value_stream_builder.dart';
import '../../../di.dart';
import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/button.dart';
import '../../../ui/theme.dart';
import '../../conversion_rates/services/watch_user_total_fiat_balance.dart';
import '../../tokens/token.dart';
import '../data/repository.dart';
import '../screens/investments_screen.dart';
import 'home_widget.dart';
import 'portfolio_tile.dart';

class InvestingWidget extends StatelessWidget {
  const InvestingWidget({super.key});

  @override
  Widget build(BuildContext context) => ValueStreamBuilder<Amount>(
        create: () => sl<WatchUserTotalFiatBalance>().call(
          ignoreTokens: [Token.usdc],
        ),
        builder: (context, balance) {
          final displayEmptyBalances = context
              .watch<InvestmentSettingsRepository>()
              .displayEmptyBalances;

          final hasNoInvestments =
              balance.decimal == Decimal.zero && !displayEmptyBalances;

          return hasNoInvestments
              ? const _StartInvestmentBanner()
              : PortfolioTile(
                  balance: balance,
                  displayEmptyBalances: displayEmptyBalances,
                );
        },
      );
}

class _StartInvestmentBanner extends StatelessWidget {
  const _StartInvestmentBanner();

  @override
  Widget build(BuildContext context) => HomeTile(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                context.l10n.investingTitle,
                style: dashboardSectionTitleTextStyle,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => context.goNamed(Routes.investments),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Assets.images.investingBanner.image(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: IgnorePointer(
                      child: CpButton(
                        text: context.l10n.startInvestingTitle,
                        minWidth: 250,
                        size: CpButtonSize.wide,
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}

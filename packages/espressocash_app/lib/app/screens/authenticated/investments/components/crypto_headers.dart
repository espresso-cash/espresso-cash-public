import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/balances/presentation/watch_balance.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../core/user_preferences.dart';
import '../../../../../features/token_search/widgets/discover_header.dart';
import '../../../../../l10n/l10n.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/header.dart';

class StartedInvestingHeader extends StatelessWidget {
  const StartedInvestingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watchUserHasInvestments()) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CpHeader(
            title: context.l10n.startedInvestingTitle,
            subtitle: context.l10n.startedInvestingSubtitle,
          ),
          const SizedBox(height: 12),
          DiscoverHeader(
            showTitle: false,
            onTap: (it) => context.router.push(TokenSearchRoute(category: it)),
          ),
        ],
      ),
    );
  }
}

class PopularCryptoHeader extends StatelessWidget {
  const PopularCryptoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.watchUserHasInvestments()) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: CpHeader(
        title: context.l10n.popularCryptoTitle,
        subtitle: context.l10n.popularCryptoSubtitle,
      ),
    );
  }
}

extension on BuildContext {
  bool watchUserHasInvestments() => watchUserTotalFiatBalance(
        watch<UserPreferences>().fiatCurrency,
        ignoreTokens: [Token.usdc],
      ).let((it) => it.decimal == Decimal.zero);
}

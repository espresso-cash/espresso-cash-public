import 'package:dfunc/dfunc.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/balances/bl/balances_bloc.dart';
import '../../../core/balances/presentation/watch_balance.dart';
import '../../../core/tokens/token.dart';
import '../src/data/repository.dart';
import 'portfolio_widget.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  static const _minimumUsdAmount = 0.01;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BalancesBloc, BalancesState>(
        builder: (context, state) {
          final displayEmptyBalances = context
              .watch<InvestmentSettingsRepository>()
              .displayEmptyBalances;

          final tokens = state.userTokens.where((e) => e != Token.usdc).let(
                (tokens) => displayEmptyBalances
                    ? tokens
                    : tokens.where((token) {
                        final balance =
                            context.watchUserFiatBalance(token)?.value ?? 0;

                        return balance >= _minimumUsdAmount;
                      }),
              );

          return PortfolioWidget(
            tokens: IList(tokens),
          );
        },
      );
}

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/balances/bl/balances_bloc.dart';
import '../data/repository.dart';
import 'components/portfolio_widget.dart';

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<BalancesBloc, BalancesState>(
        builder: (context, state) {
          final displayEmptyBalances = context
              .watch<InvestmentSettingsRepository>()
              .displayEmptyBalances;

          return PortfolioWidget(
            tokens: IList(
              displayEmptyBalances
                  ? state.userTokens
                  : state.userTokensWithPositiveBalance,
            ),
          );
        },
      );
}

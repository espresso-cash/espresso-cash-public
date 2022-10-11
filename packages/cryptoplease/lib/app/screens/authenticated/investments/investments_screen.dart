import 'package:cryptoplease/app/components/refresh_balance_wrapper.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/balance_list_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/popular_tokens.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/stablecoin_empty_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/total_balance_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/wallet_tab_bar.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, onRefresh) =>
            BlocBuilder<BalancesBloc, BalancesState>(
          builder: (context, state) {
            final total = context.watchUserTotalFiatBalance(
              context.watch<UserPreferences>().fiatCurrency,
            );

            final isLoading = state.processingState.maybeMap(
              processing: (_) => true,
              orElse: () => false,
            );

            return DefaultTabController(
              length: 3,
              child: CpHeaderedList(
                onRefresh: onRefresh,
                headerAppBar: const _AppBarContent(),
                headerContent: TotalBalanceWidget(balance: total),
                stickyBottomHeader: const WalletTabBar(),
                child: CustomScrollView(
                  primary: true,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 425,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            BalanceListWidget(
                              tokens: state.nonStableTokens,
                              isLoading: isLoading,
                              emptyWidget: CpEmptyMessageWidget(
                                message: context.l10n.noDataPullToRefresh,
                              ),
                            ),
                            BalanceListWidget(
                              tokens: state.stableTokens,
                              isLoading: isLoading,
                              emptyWidget: const StableCoinEmptyWidget(),
                            ),
                            BalanceListWidget(
                              tokens: state.userTokens,
                              isLoading: isLoading,
                              emptyWidget: CpEmptyMessageWidget(
                                message: context.l10n.noDataPullToRefresh,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: PopularTokens(),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: kToolbarHeight,
        child: Center(
          child: Text(
            context.l10n.investments,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
}

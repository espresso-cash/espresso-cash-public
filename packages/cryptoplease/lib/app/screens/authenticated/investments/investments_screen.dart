import 'package:cryptoplease/app/components/refresh_balance_wrapper.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/balance_list_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/popular_crypto_header.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/popular_token_list.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/portfolio_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/stablecoin_empty_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/total_balance_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/wallet_tab_bar.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/colors.dart';
import 'package:cryptoplease/ui/empty_message_widget.dart';
import 'package:cryptoplease/ui/headered_list/headered_list.dart';
import 'package:cryptoplease/ui/navigation_bar/navigation_bar.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
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
            final isLoading = state.processingState.maybeMap(
              processing: (_) => true,
              orElse: () => false,
            );

            return Material(
              color: Colors.white,
              child: RefreshIndicator(
                displacement: 80,
                onRefresh: onRefresh,
                color: CpColors.primaryColor,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      shape: const Border(),
                      title: Text(context.l10n.investments),
                      pinned: true,
                      snap: false,
                      floating: false,
                      elevation: 0,
                      backgroundColor: Colors.white,
                      expandedHeight: 200,
                      collapsedHeight: 100,
                      flexibleSpace: const TotalBalanceWidget(),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      sliver: PortfolioWidget(tokens: IList(state.userTokens)),
                    ),
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(top: 54, bottom: 24),
                        child: PopularCryptoHeader(),
                      ),
                    ),
                    const PopularTokenList(),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: cpNavigationBarheight + 56),
                    )
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

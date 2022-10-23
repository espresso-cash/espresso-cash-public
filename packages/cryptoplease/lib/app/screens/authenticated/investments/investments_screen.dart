import 'package:cryptoplease/app/components/refresh_balance_wrapper.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/popular_crypto_header.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/popular_token_list.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/portfolio_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/investments/components/total_balance_widget.dart';
import 'package:cryptoplease/core/balances/bl/balances_bloc.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:cryptoplease/ui/colors.dart';
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
          builder: (context, state) => Material(
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
                    expandedHeight: MediaQuery.of(context).padding.top +
                        kToolbarHeight +
                        100,
                    collapsedHeight: kToolbarHeight + 40,
                    flexibleSpace: Padding(
                      padding: EdgeInsets.only(
                        top:
                            MediaQuery.of(context).padding.top + kToolbarHeight,
                        bottom: 16,
                      ),
                      child: const TotalBalanceWidget(),
                    ),
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
          ),
        ),
      );
}

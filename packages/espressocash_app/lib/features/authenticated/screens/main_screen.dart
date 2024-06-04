import 'dart:math';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../../di.dart';
import '../../../ui/colors.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/theme.dart';
import '../../../ui/value_stream_builder.dart';
import '../../activities/services/tx_updater.dart';
import '../../activities/widgets/recent_activity.dart';
import '../../balances/data/repository.dart';
import '../../currency/models/amount.dart';
import '../../tokens/token.dart';
import '../widgets/home_add_cash.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_carousel.dart';
import '../widgets/investment_header.dart';
import '../widgets/portfolio_widget.dart';
import '../widgets/refresh_balance_wrapper.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
    required this.onSendMoneyPressed,
    required this.onTransactionsPressed,
  });

  final VoidCallback onSendMoneyPressed;
  final VoidCallback onTransactionsPressed;

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: ValueStreamBuilder<bool>(
          create: () => (
            sl<TokenBalancesRepository>()
                .watchUserTokens()
                .map((it) => it.isEmpty),
            true
          ),
          builder: (context, isEmpty) => isEmpty
              ? const HomeAddCashContent()
              : _MainContent(
                  onSendMoneyPressed: onSendMoneyPressed,
                  onTransactionsPressed: onTransactionsPressed,
                ),
        ),
      );
}

class _MainContent extends StatefulWidget {
  const _MainContent({
    required this.onSendMoneyPressed,
    required this.onTransactionsPressed,
  });

  final VoidCallback onSendMoneyPressed;
  final VoidCallback onTransactionsPressed;

  @override
  State<_MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<_MainContent> {
  final ScrollController _scrollController = ScrollController();
  Color _appBarColor = CpColors.darkGoldBackgroundColor;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_scrollListener)
      ..dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 150) {
      _appBarColor = CpColors.dashboardBackgroundColor;
    } else {
      _appBarColor = CpColors.darkGoldBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
        decoration: const BoxDecoration(
          color: CpColors.dashboardBackgroundColor,
        ),
        child: RefreshBalancesWrapper(
          builder: (context, onRefresh) => RefreshIndicator(
            displacement: 80,
            onRefresh: () => Future.wait([
              onRefresh(),
              sl<TxUpdater>().call(),
            ]),
            color: CpColors.primaryColor,
            backgroundColor: Colors.white,
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                AnimatedBuilder(
                  animation: _scrollController,
                  builder: (context, child) => HomeAppBar(
                    backgroundColor: _appBarColor,
                    scrollController: _scrollController,
                  ),
                ),
                SliverToBoxAdapter(
                  child: InvestmentHeader(
                    onSendMoneyPressed: widget.onSendMoneyPressed,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 28,
                      bottom: 18,
                    ),
                    color: CpColors.dashboardBackgroundColor,
                    child: const Divider(
                      color: CpColors.homeDividerColor,
                      thickness: 1.0,
                      height: 1.0,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: Divider(
                      color: CpColors.homeDividerColor,
                      thickness: 1.0,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: ValueStreamBuilder<IList<CryptoAmount>>(
                    create: () => (
                      sl<TokenBalancesRepository>().watchTokenBalances(
                        ignoreTokens: [Token.usdc],
                      ),
                      const IListConst([])
                    ),
                    builder: (context, tokens) => tokens.isNotEmpty
                        ? const SizedBox.shrink()
                        : HomeCarouselWidget(
                            onSendMoneyPressed: widget.onSendMoneyPressed,
                          ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: PortfolioWidget(),
                ),
                SliverToBoxAdapter(
                  child: RecentActivityWidget(
                    onSendMoneyPressed: widget.onSendMoneyPressed,
                    onTransactionsPressed: widget.onTransactionsPressed,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: max(
                      0,
                      MediaQuery.paddingOf(context).bottom -
                          cpNavigationBarheight +
                          16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

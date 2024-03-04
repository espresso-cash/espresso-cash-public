import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../gen/assets.gen.dart';
import '../../../l10n/l10n.dart';
import '../../../routing.dart';
import '../../../ui/back_button.dart';
import '../../../ui/colors.dart';
import '../../../ui/icon_button.dart';
import '../../../ui/navigation_bar/navigation_bar.dart';
import '../../../ui/page_fade_wrapper.dart';
import '../../../ui/theme.dart';
import '../../balances/widgets/refresh_balance_wrapper.dart';
import '../../favorite_tokens/widgets/extensions.dart';
import '../../favorite_tokens/widgets/favorite_tokens_list.dart';
import '../../popular_tokens/widgets/extensions.dart';
import '../../popular_tokens/widgets/popular_token_list.dart';
import '../../token_search/screens/token_search_screen.dart';
import '../widgets/crypto_investments.dart';
import '../widgets/popular_crypto_header.dart';
import '../widgets/start_investing_header.dart';

class InvestmentsScreen extends StatelessWidget {
  const InvestmentsScreen({super.key});

  @override
  Widget build(BuildContext context) => CpTheme.light(
        child: PageFadeWrapper(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
            child: RefreshBalancesWrapper(
              builder: (context, onRefresh) => RefreshIndicator(
                displacement: 80,
                onRefresh: () => Future.wait([
                  onRefresh(),
                  context.refreshPopularTokens(),
                  context.refreshFavorites(),
                ]),
                color: CpColors.primaryColor,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: const Center(
                        child: CpBackButton(),
                      ),
                      backgroundColor: Colors.white,
                      shape: const Border(),
                      title: Center(
                        child: Text(context.l10n.investingTitle.toUpperCase()),
                      ),
                      pinned: true,
                      snap: false,
                      floating: false,
                      elevation: 0,
                      actions: [
                        CpIconButton(
                          icon: Assets.icons.searchButtonIcon
                              .svg(color: Colors.white),
                          variant: CpIconButtonVariant.black,
                          onPressed: () =>
                              const TokenSearchRoute(null).go(context),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    const SliverToBoxAdapter(child: StartInvestingHeader()),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    const SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      sliver: CryptoInvestments(),
                    ),
                    const FavoriteTokenList(),
                    const SliverToBoxAdapter(child: SizedBox(height: 24)),
                    const SliverToBoxAdapter(child: PopularCryptoHeader()),
                    const PopularTokenList(),
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
          ),
        ),
      );
}

class InvestmentsRoute extends GoRouteData {
  const InvestmentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InvestmentsScreen();
}

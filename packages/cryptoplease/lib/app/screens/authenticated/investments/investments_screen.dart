import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/balances/presentation/refresh_balance_wrapper.dart';
import '../../../../features/favorite_tokens/widgets/extensions.dart';
import '../../../../features/favorite_tokens/widgets/favorite_tokens_list.dart';
import '../../../../features/investments/widgets/my_portfolio.dart';
import '../../../../features/popular_tokens/widgets/extensions.dart';
import '../../../../features/popular_tokens/widgets/popular_token_list.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../routes.gr.dart';
import '../../../../ui/colors.dart';
import '../../../../ui/icon_button.dart';
import '../../../../ui/navigation_bar/navigation_bar.dart';
import 'components/investment_header.dart';
import 'components/popular_crypto_header.dart';
import 'components/total_balance_widget.dart';

class InvestmentsScreen extends StatefulWidget {
  const InvestmentsScreen({Key? key}) : super(key: key);

  @override
  State<InvestmentsScreen> createState() => _InvestmentsScreenState();
}

class _InvestmentsScreenState extends State<InvestmentsScreen> {
  @override
  Widget build(BuildContext context) => RefreshBalancesWrapper(
        builder: (context, onRefresh) => RefreshIndicator(
          displacement: 80,
          onRefresh: () => Future.wait([
            onRefresh(),
            context.refreshPopularTokens(),
            context.refreshFavorites(),
          ]),
          color: CpColors.primaryColor,
          child: const CustomScrollView(
            slivers: [
              SliverAppBar(
                shape: Border(),
                title: _AppBarContent(),
                pinned: true,
                snap: false,
                floating: false,
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              SliverToBoxAdapter(child: InvestmentHeader()),
              SliverToBoxAdapter(child: TotalBalanceWidget()),
              SliverPadding(
                padding: EdgeInsets.only(left: 24, right: 24),
                sliver: MyPortfolio(),
              ),
              FavoriteTokenList(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 32, bottom: 24),
                  child: PopularCryptoHeader(),
                ),
              ),
              PopularTokenList(),
              SliverToBoxAdapter(
                child: SizedBox(height: cpNavigationBarheight + 56),
              ),
            ],
          ),
        ),
      );
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: kToolbarHeight,
        child: Stack(
          children: [
            Center(
              child: Assets.images.logoDark.image(height: 32),
            ),
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Row(
                children: [
                  CpIconButton(
                    icon: Assets.icons.searchButtonIcon.svg(),
                    onPressed: () =>
                        context.router.push(const TokenSearchRoute()),
                  ),
                  const SizedBox(width: 12),
                  CpIconButton(
                    icon: Assets.icons.settingsButtonIcon.svg(),
                    onPressed: () => context.router.push(const ProfileRoute()),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}

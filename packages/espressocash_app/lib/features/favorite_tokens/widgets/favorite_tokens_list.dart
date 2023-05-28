import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../../core/tokens/token.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/token_icon.dart';
import '../../../core/conversion_rates/context_ext.dart';
import '../../../core/presentation/extensions.dart';
import '../../../core/user_preferences.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../../../ui/theme.dart';
import '../src/bl/bloc.dart';
import '../src/bl/repository.dart';

class FavoriteTokenList extends StatefulWidget {
  const FavoriteTokenList({super.key});

  @override
  State<FavoriteTokenList> createState() => _FavoriteTokenListState();
}

class _FavoriteTokenListState extends State<FavoriteTokenList> {
  late final Stream<List<Token>> _stream;

  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(const FavoritesEvent.refreshRequested());
    _stream = sl<FavoriteTokenRepository>().watch();
  }

  @override
  Widget build(BuildContext context) {
    final currency = context.watch<UserPreferences>().fiatCurrency;

    return StreamBuilder<List<Token>>(
      stream: _stream,
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null || data.isEmpty) {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }

        final items = data.map((e) {
          final price = context.watchConversionRate(from: e, to: currency);

          return _TokenItem(e, price);
        }).toList();

        return SliverPadding(
          padding: const EdgeInsets.only(top: 32, left: 24, right: 24),
          sliver: MultiSliver(
            children: [
              const SliverToBoxAdapter(child: _FollowingTitle()),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(items),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FollowingTitle extends StatelessWidget {
  const _FollowingTitle();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Text(
          context.l10n.following,
          style: dashboardSectionTitleTextStyle,
        ),
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem(this.token, this.currentPrice);

  final Token token;
  final Decimal? currentPrice;

  @override
  Widget build(BuildContext context) {
    final fiatCurrency = context.watch<UserPreferences>().fiatCurrency;
    final currentPrice = this.currentPrice.formatDisplayablePrice(
          locale: DeviceLocale.localeOf(context),
          currency: fiatCurrency,
        );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.router.push(TokenDetailsRoute(token: token)),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 16),
          decoration: const BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CpTokenIcon(token: token, size: 36),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  token.name,
                  style: _titleStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                currentPrice,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: CpColors.menuPrimaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

const _titleStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15.0,
  color: CpColors.menuPrimaryTextColor,
);

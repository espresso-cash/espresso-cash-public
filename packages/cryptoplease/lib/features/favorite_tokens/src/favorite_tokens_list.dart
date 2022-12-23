import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/token_icon.dart';
import '../../../core/amount.dart';
import '../../../core/user_preferences.dart';
import '../../../di.dart';
import '../../../l10n/device_locale.dart';
import '../../../l10n/l10n.dart';
import '../module.dart';

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
    _stream = sl<FavoriteTokenRepository>().watch();
  }

  @override
  Widget build(BuildContext context) {
    final conversionRates = context.watch<FavoritesBloc>().state.tokens;

    return StreamBuilder<List<Token>>(
      stream: _stream,
      builder: (context, snapshot) {
        final data = snapshot.data;

        if (data == null || data.isEmpty) {
          return const SliverToBoxAdapter(
            child: SizedBox.shrink(),
          );
        }

        final items =
            data.map((e) => _TokenItem(e, conversionRates[e])).toList();

        return SliverPadding(
          padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
          sliver: MultiSliver(
            children: [
              const SliverToBoxAdapter(child: _FollowingTitle()),
              SliverPadding(
                padding: const EdgeInsets.only(top: 16),
                sliver: SliverStack(
                  children: [
                    const _Background(),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(items),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const SliverPositioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
        ),
      );
}

class _FollowingTitle extends StatelessWidget {
  const _FollowingTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        context.l10n.following,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          letterSpacing: 0.17,
          color: CpColors.menuPrimaryTextColor,
        ),
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem(this.token, this.currentPrice);

  final Token token;
  final Decimal? currentPrice;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;
    final currentPrice = this.currentPrice;

    final Amount? tokenRate = currentPrice == null
        ? null
        : Amount.fromDecimal(currency: fiatCurrency, value: currentPrice);

    return ListTile(
      onTap: () => context.router.push(TokenDetailsRoute(token: token)),
      leading: CpTokenIcon(token: token, size: 37),
      title: Text(
        token.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        tokenRate?.format(locale) ?? '-',
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: Colors.black,
        ),
      ),
    );
  }
}

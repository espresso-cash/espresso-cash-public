import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../core/user_preferences.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/token_icon.dart';
import '../../di.dart';
import '../../ui/loader.dart';
import 'src/market_bloc.dart';

final _defaultTokens = [
  Token.sol,
  Token.usdc,
];

class PopularTokenList extends StatelessWidget {
  const PopularTokenList({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => sl<MarketBloc>(
          param1: context.read<UserPreferences>().fiatCurrency,
        )..add(const MarketEventFetch()),
        child: BlocBuilder<MarketBloc, MarketDetailsState>(
          builder: (context, state) {
            const loader = SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: LoadingIndicator(),
              ),
            );

            return state.when(
              initial: () => loader,
              processing: () => loader,
              failure: (_) => SliverList(
                delegate: SliverChildListDelegate(
                  _defaultTokens.map((e) => _TokenItem(e, 0.0)).toList(),
                ),
              ),
              success: (data) => SliverList(
                delegate: SliverChildListDelegate(
                  data.entries.map((e) => _TokenItem(e.key, e.value)).toList(),
                ),
              ),
            );
          },
        ),
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem(this.token, this.currentPrice);

  final Token token;
  final double currentPrice;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;

    final Amount tokenRate = Amount.fromDecimal(
      currency: fiatCurrency,
      value: Decimal.parse(currentPrice.toString()),
    );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
      child: ListTile(
        onTap: () => context.router.push(TokenDetailsRoute(token: token)),
        leading: CpTokenIcon(token: token, size: 37),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                token.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _TokenSymbolWidget(token.symbol),
          ],
        ),
        trailing: Text(
          tokenRate.format(locale),
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _TokenSymbolWidget extends StatelessWidget {
  const _TokenSymbolWidget(
    this.symbol, {
    Key? key,
  }) : super(key: key);

  final String symbol;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 57,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 6,
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: CpColors.lightPillBackgroundColor,
          ),
          child: Center(
            widthFactor: 1,
            child: Text(
              symbol.toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ),
      );
}

import 'package:auto_route/auto_route.dart';
import 'package:dfunc/dfunc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/amount.dart';
import '../../../../../core/conversion_rates/context_ext.dart';
import '../../../../../core/presentation/format_amount.dart';
import '../../../../../core/tokens/token.dart';
import '../../../../../core/user_preferences.dart';
import '../../../../../l10n/device_locale.dart';
import '../../../../../routes.gr.dart';
import '../../../../../ui/colors.dart';
import '../../../../../ui/token_icon.dart';

final _popularTokenList = <Token>[
  Token.sol,
];

class PopularTokenList extends StatelessWidget {
  const PopularTokenList({super.key});

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(
          _popularTokenList.map(_TokenItem.new).toList(),
        ),
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem(this.token);
  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);
    final fiatCurrency = context.read<UserPreferences>().fiatCurrency;
    final Amount? tokenRate = context
        .watchConversionRate(from: token, to: fiatCurrency)
        ?.let((it) => Amount.fromDecimal(value: it, currency: fiatCurrency));

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: ListTile(
        onTap: () => context.router.push(TokenDetailsRoute(token: token)),
        leading: CpTokenIcon(token: token, size: 37),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 90,
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
          tokenRate?.format(locale) ?? ' -',
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
              maxLines: 1,
            ),
          ),
        ),
      );
}

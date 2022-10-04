import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/app/routes.gr.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease/l10n/l10n.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _popularTokenList = <Token>[
  Token.sol,
];

class PopularTokens extends StatelessWidget {
  const PopularTokens({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            context.l10n.popularCryptoTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 33,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.popularCryptoSubtitle,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 24),
            child: Assets.images.portfolioGraph.svg(),
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            itemCount: _popularTokenList.length,
            itemBuilder: (context, index) {
              final token = _popularTokenList[index];

              return _TokenItem(token);
            },
          ),
          const SizedBox(height: cpNavigationBarheight + 16),
        ],
      );
}

class _TokenItem extends StatelessWidget {
  const _TokenItem(this.token);
  final Token token;

  @override
  Widget build(BuildContext context) {
    final locale = DeviceLocale.localeOf(context);

    final currency = context.read<UserPreferences>().fiatCurrency;

    final conversion =
        context.readConversionRate(from: token, to: Currency.usd) ??
            Decimal.fromInt(0);

    final tokenRate = Amount.fromDecimal(value: conversion, currency: currency);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 24),
      child: ListTile(
        onTap: () => context.router.push(TokenRoute(token: token)),
        leading: TokenIcon(token: token, size: 37),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
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
            color: Color(0xffEAEAEA),
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

import 'package:auto_route/auto_route.dart';
import 'package:cryptoplease/app/components/token_icon.dart';
import 'package:cryptoplease/app/screens/authenticated/components/balance_overview_widget.dart';
import 'package:cryptoplease/app/screens/authenticated/components/navigation_bar/navigation_bar.dart';
import 'package:cryptoplease/core/amount.dart';
import 'package:cryptoplease/core/balances/presentation/watch_balance.dart';
import 'package:cryptoplease/core/conversion_rates/presentation/conversion_rates.dart';
import 'package:cryptoplease/core/currency.dart';
import 'package:cryptoplease/core/presentation/format_amount.dart';
import 'package:cryptoplease/core/tokens/token.dart';
import 'package:cryptoplease/core/user_preferences.dart';
import 'package:cryptoplease/features/token_info/bl/token_info_bloc.dart';
import 'package:cryptoplease/l10n/device_locale.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:decimal/decimal.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletRouterScreen extends StatefulWidget {
  const WalletRouterScreen({super.key});

  @override
  State<WalletRouterScreen> createState() => _WalletRouterScreenState();
}

class _WalletRouterScreenState extends State<WalletRouterScreen> {
  final routerKey = GlobalKey<AutoRouterState>();

  @override
  Widget build(BuildContext context) => AutoRouter(key: routerKey);
}

class TokenScreen extends StatefulWidget {
  const TokenScreen({super.key, required this.token});

  final Token token;

  @override
  State<TokenScreen> createState() => _TokenScreenState();
}

class _TokenScreenState extends State<TokenScreen> {
  @override
  void initState() {
    super.initState();

    context.read<TokenInfoBloc>().add(FetchRequested(token: widget.token));
  }

  @override
  Widget build(BuildContext context) => CpTheme.dark(
        child: Scaffold(
          backgroundColor: CpColors.darkBackground,
          body: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: cpNavigationBarheight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _Header(widget.token),
                  const Expanded(child: _TokenChart()),
                  const _Buttons(),
                  const _TokenInfo(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _Header extends StatelessWidget {
  const _Header(this.token);
  final Token token;

  @override
  Widget build(BuildContext context) {
    final Amount? fiatAmount = context.watchUserFiatBalance(token);
    final locale = DeviceLocale.localeOf(context);

    final currency = context.read<UserPreferences>().fiatCurrency;

    final conversion = context.readConversionRate(
          from: token,
          to: Currency.usd,
        ) ??
        Decimal.fromInt(0);

    final test = Amount.fromDecimal(value: conversion, currency: currency);

    const balanceUpdate = Amount.fiat(
      value: 100000,
      currency: Currency.usd,
    );
    final checkedDate = DateTime.now();
    const percentageDifference = 7.25;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                TokenIcon(token: token, size: 60),
                Text(
                  token.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
                ),
                Text(
                  test.format(locale), //TODO
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                if (checkedDate != null) ...[
                  const SizedBox(height: 4),
                  BalanceOverviewWidget(
                    balance: balanceUpdate,
                    checkedDate: checkedDate,
                    percentageDifference: percentageDifference,
                  )
                ]
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: BackButton(onPressed: () => context.router.pop()),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _AmountDisplay(fiatAmount?.format(locale) ?? '-'),
            ),
          )
        ],
      ),
    );
  }
}

class _AmountDisplay extends StatelessWidget {
  //TODO
  const _AmountDisplay(
    this.amount, {
    Key? key,
  }) : super(key: key);

  final String amount;

  @override
  Widget build(BuildContext context) => SizedBox(
        // width: 100,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 12,
          ),
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: Color(0xff464646), //TODO
          ),
          child: Center(
            widthFactor: 1,
            child: Text(
              amount,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
            ),
          ),
        ),
      );
}

enum ChartRange {
  oneDay('1D'),
  oneWeek('1W'),
  oneMonth('1M'),
  threeMonth('3M'),
  oneYear('1Y'),
  all('ALL');

  const ChartRange(this.label);

  final String label;
}

class _TokenChart extends StatelessWidget {
  const _TokenChart();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TokenInfoBloc, TokenInfoState>(
        builder: (context, state) {
          final data = state.chart;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SizedBox(
              height: 200,
              child: Column(
                children: [
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: data
                                .map(
                                  (e) => FlSpot(
                                    e.date?.millisecondsSinceEpoch.toDouble() ??
                                        0.0,
                                    e.price ?? 0,
                                  ),
                                )
                                .toList(),
                            isCurved: true,
                            dotData: FlDotData(show: false),
                            color: const Color(0xffF9653E), //TODO
                            barWidth: 4,
                          )
                        ],
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(show: false),
                        lineTouchData: LineTouchData(
                          enabled: true,
                          getTouchedSpotIndicator: (
                            LineChartBarData barData,
                            List<int> indicators,
                          ) =>
                              indicators.map(
                            (int index) {
                              final line = FlLine(
                                color: Colors.grey,
                                strokeWidth: 1,
                                dashArray: [2, 4],
                              );

                              return TouchedSpotIndicatorData(
                                line,
                                FlDotData(show: true),
                              );
                            },
                          ).toList(),
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: const Color(0xff464646), //TODO
                            getTooltipItems: (touchedSpots) => touchedSpots.map(
                              (LineBarSpot touchedSpot) {
                                final price =
                                    data[touchedSpot.spotIndex].price ?? 0;

                                return LineTooltipItem(
                                  price.toStringAsFixed(2),
                                  const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                          getTouchLineEnd: (_, __) => 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const _ChartRangeSelector(
                    onItemSelected: print,
                  ),
                ],
              ),
            ),
          );
        },
      );
}

class _ChartRangeSelector extends StatefulWidget {
  const _ChartRangeSelector({required this.onItemSelected});

  final void Function(ChartRange) onItemSelected;

  @override
  State<_ChartRangeSelector> createState() => __ChartRangeSelectorState();
}

class __ChartRangeSelectorState extends State<_ChartRangeSelector> {
  late ChartRange _selected;

  @override
  void initState() {
    super.initState();

    _selected = ChartRange.oneWeek;
  }

  @override
  Widget build(BuildContext context) => Row(
        //TODO
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...ChartRange.values
              .map(
                (e) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _selected = e;
                      widget.onItemSelected(e);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: _selected == e
                        ? const ShapeDecoration(
                            shape: StadiumBorder(),
                            color: Color(0xff181818), //TODO
                          )
                        : null,
                    child: Text(
                      e.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      );
}

class _Buttons extends StatelessWidget {
  const _Buttons();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: CpButton(text: 'Buy', onPressed: () {})),
            Flexible(child: CpButton(text: 'Sell', onPressed: () {})),
            Flexible(child: CpButton(text: 'Send', onPressed: () {}))
          ],
        ),
      );
}

class _TokenInfo extends StatelessWidget {
  const _TokenInfo();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'About Solana',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Solana is an open source project implementing a new, high-performance, permissionless blockchain. The Solana Foundation is based in Geneva, Switzerland and maintains the open source project.',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            )
          ],
        ),
      );
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/user_preferences.dart';
import '../../../../ui/colors.dart';
import '../../bl/token_chart_bloc.dart';
import '../../data/coingecko_client.dart';
import 'loading.dart';

enum ChartInterval {
  oneDay('1D', '1'),
  oneWeek('1W', '7'),
  oneMonth('1M', '30'),
  threeMonth('3M', '90'),
  oneYear('1Y', '365'),
  all('ALL', 'max');

  const ChartInterval(this.label, this.value);

  final String label;
  final String value;
}

class TokenChart extends StatelessWidget {
  const TokenChart({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TokenChartBloc, TokenChartState>(
        builder: (context, state) {
          final data = state.chart;
          final isLoading = state.processingState.isProcessing;

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            height: 350,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      _ChartWidget(data: data),
                      if (isLoading) const TokenLoadingIndicator()
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _ChartRangeSelector(
                  interval: state.interval,
                  onItemSelected: (interval) {
                    context.read<TokenChartBloc>().add(
                          FetchChartRequested(interval: interval),
                        );
                  },
                ),
              ],
            ),
          );
        },
      );
}

class _ChartWidget extends StatelessWidget {
  const _ChartWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<TokenChartItem> data;

  @override
  Widget build(BuildContext context) {
    final sign = context.read<UserPreferences>().fiatCurrency.sign;

    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: data
                .map(
                  (e) => FlSpot(
                    e.date?.millisecondsSinceEpoch.toDouble() ?? 0.0,
                    e.price ?? 0,
                  ),
                )
                .toList(),
            isCurved: true,
            dotData: FlDotData(show: false),
            color: CpColors.chartLineColor,
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
            tooltipBgColor: CpColors.lightBackgroundColor,
            getTooltipItems: (touchedSpots) => touchedSpots.map(
              (LineBarSpot touchedSpot) {
                final price = data[touchedSpot.spotIndex].price ?? 0;

                return LineTooltipItem(
                  '$sign${price.toStringAsFixed(2)}',
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
      swapAnimationDuration: Duration.zero,
    );
  }
}

class _ChartRangeSelector extends StatelessWidget {
  const _ChartRangeSelector({
    required this.onItemSelected,
    required this.interval,
  });

  final void Function(ChartInterval) onItemSelected;
  final ChartInterval interval;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...ChartInterval.values
              .map(
                (e) => GestureDetector(
                  onTap: () => onItemSelected.call(e),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    decoration: interval == e
                        ? const ShapeDecoration(
                            shape: StadiumBorder(),
                            color: CpColors.darkBackgroundColor,
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

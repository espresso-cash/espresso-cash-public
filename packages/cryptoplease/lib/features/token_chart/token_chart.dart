import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ui/colors.dart';
import '../../core/tokens/token.dart';
import '../../di.dart';
import '../../ui/loader.dart';
import 'src/bloc.dart';
import 'src/chart_interval.dart';
import 'src/date_format.dart';
import 'src/token_chart_item.dart';

export 'src/token_chart_item.dart';

class TokenChart extends StatelessWidget {
  const TokenChart({super.key, required this.token, this.onSelect});

  final Token token;
  final void Function(TokenChartItem?)? onSelect;

  @override
  Widget build(BuildContext context) => BlocProvider<TokenChartBloc>(
        create: (_) => sl<TokenChartBloc>(param1: token)
          ..add(const FetchChartRequested(interval: ChartInterval.oneMonth)),
        child: BlocBuilder<TokenChartBloc, TokenChartState>(
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
                        _ChartWidget(
                          data: data,
                          onSelect: onSelect,
                        ),
                        if (isLoading) const LoadingIndicator()
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
        ),
      );
}

class _ChartWidget extends StatelessWidget {
  const _ChartWidget({
    Key? key,
    required this.data,
    this.onSelect,
  }) : super(key: key);

  final IList<TokenChartItem> data;
  final void Function(TokenChartItem?)? onSelect;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: LineChart(
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
              touchCallback: (event, lineResponse) {
                final selectedIndex =
                    lineResponse?.lineBarSpots?.first.spotIndex;

                if (onSelect != null) {
                  if (selectedIndex == null ||
                      event is FlTapUpEvent ||
                      event is FlLongPressEnd) {
                    onSelect?.call(null);
                  } else {
                    onSelect?.call(data[selectedIndex]);
                  }
                }
              },
              getTouchedSpotIndicator: (
                LineChartBarData barData,
                List<int> indicators,
              ) =>
                  indicators.map(
                (int index) {
                  final line = FlLine(
                    color: Colors.white,
                    strokeWidth: 1,
                    dashArray: [5, 5],
                  );

                  final dot = FlDotData(
                    getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
                      radius: 5,
                      color: CpColors.yellowColor,
                    ),
                  );

                  return TouchedSpotIndicatorData(line, dot);
                },
              ).toList(),
              touchTooltipData: LineTouchTooltipData(
                fitInsideHorizontally: true,
                tooltipBgColor: Colors.transparent,
                showOnTopOfTheChartBoxArea: true,
                tooltipMargin: 10,
                getTooltipItems: (touchedSpots) => touchedSpots.map(
                  (LineBarSpot touchedSpot) {
                    final date = data[touchedSpot.spotIndex].date;

                    return LineTooltipItem(
                      date != null ? formatDate(date) : '-',
                      const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    );
                  },
                ).toList(),
              ),
              getTouchLineEnd: (_, __) => double.infinity,
            ),
          ),
          swapAnimationDuration: Duration.zero,
        ),
      );
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
                      horizontal: 18,
                    ),
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color:
                          interval == e ? CpColors.darkBackgroundColor : null,
                    ),
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

extension on ChartInterval {
  String get label {
    switch (this) {
      case ChartInterval.oneDay:
        return '1D';
      case ChartInterval.oneWeek:
        return '1W';
      case ChartInterval.oneMonth:
        return '1M';
      case ChartInterval.threeMonth:
        return '3M';
      case ChartInterval.oneYear:
        return '1Y';
      case ChartInterval.all:
        return 'ALL';
    }
  }
}

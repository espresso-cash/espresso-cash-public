import 'package:decimal/decimal.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ui/colors.dart';
import '../../../core/presentation/extensions.dart';
import '../../../core/tokens/token.dart';
import '../../../core/user_preferences.dart';
import '../../../l10n/device_locale.dart';
import '../../../ui/loader.dart';
import '../src/bloc.dart';
import '../src/chart_interval.dart';
import '../src/date_format.dart';
import '../src/token_chart_item.dart';

export '../src/token_chart_item.dart';

class TokenChart extends StatelessWidget {
  const TokenChart({
    super.key,
    required this.token,
    required this.onSelect,
  });

  final Token token;
  final ValueSetter<TokenChartItem?> onSelect;

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
                      _ChartWidget(
                        data: data,
                        onSelect: onSelect,
                        interval: state.interval,
                      ),
                      if (isLoading) const LoadingIndicator()
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                _ChartRangeSelector(
                  interval: state.interval,
                  onItemSelected: (interval) => context
                      .read<TokenChartBloc>()
                      .add(FetchChartRequested(interval: interval)),
                ),
              ],
            ),
          );
        },
      );
}

class _ChartWidget extends StatelessWidget {
  const _ChartWidget({
    required this.data,
    required this.onSelect,
    required this.interval,
  });

  final IList<TokenChartItem> data;
  final ValueSetter<TokenChartItem?> onSelect;
  final ChartInterval interval;

  static final _touchedSpotIndicatorData = TouchedSpotIndicatorData(
    FlLine(
      color: Colors.white,
      strokeWidth: 1,
      dashArray: [5, 5],
    ),
    FlDotData(
      getDotPainter: (_, __, ___, ____) => FlDotCirclePainter(
        radius: 6,
        color: CpColors.yellowColor,
        strokeWidth: 0,
      ),
    ),
  );

  LineTouchTooltipData _createTooltipData() {
    LineTooltipItem createTooltipItem(LineBarSpot touchedSpot) {
      final date = data[touchedSpot.spotIndex].date;

      return LineTooltipItem(
        date != null
            ? formatDate(date, showDay: interval == ChartInterval.oneWeek)
            : '-',
        const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );
    }

    return LineTouchTooltipData(
      fitInsideHorizontally: true,
      tooltipBgColor: Colors.transparent,
      showOnTopOfTheChartBoxArea: true,
      tooltipMargin: -30,
      maxContentWidth: 300,
      getTooltipItems: (touchedSpots) =>
          touchedSpots.map(createTooltipItem).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    FlSpot createSpot(TokenChartItem e) => FlSpot(
          e.date?.millisecondsSinceEpoch.toDouble() ?? 0.0,
          e.price ?? 0,
        );

    final spots = data.map(createSpot).toList();

    if (spots.isEmpty) {
      return const SizedBox.shrink();
    }

    final fiatCurrency = context.watch<UserPreferences>().fiatCurrency;

    double minY = spots.first.y;
    double maxY = spots.first.y;

    for (final FlSpot spot in spots) {
      if (spot.y < minY) {
        minY = spot.y;
      }
      if (spot.y > maxY) {
        maxY = spot.y;
      }
    }

    final range = maxY - minY;
    final interval = range / 3;
    final padding = range * 0.1;
    final chartMinY = (minY / interval).floorToDouble() * interval - padding;
    final chartMaxY = (maxY / interval).ceilToDouble() * interval + padding;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Stack(
        children: [
          const _ChartBackground(),
          LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  dotData: FlDotData(show: false),
                  color: CpColors.chartLineColor,
                  barWidth: 5,
                  isStrokeJoinRound: true,
                  isStrokeCapRound: true,
                )
              ],
              minY: chartMinY,
              maxY: chartMaxY,
              gridData: FlGridData(
                show: true,
                horizontalInterval: interval,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: const Color(0xff454141),
                  strokeWidth: 1,
                  dashArray: [2, 2],
                ),
                drawVerticalLine: false,
              ),
              backgroundColor: const Color(0xff272525),
              borderData: FlBorderData(
                show: true,
                border: _border,
              ),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: AxisTitles(sideTitles: SideTitles()),
                topTitles: AxisTitles(sideTitles: SideTitles()),
                bottomTitles: AxisTitles(sideTitles: SideTitles()),
                rightTitles: AxisTitles(
                  drawBehindEverything: true,
                  sideTitles: SideTitles(
                    reservedSize: 50,
                    showTitles: true,
                    interval: interval,
                    getTitlesWidget: (val, __) {
                      if (val == chartMaxY || val == chartMinY) {
                        return const SizedBox.shrink();
                      }

                      final formattedValue =
                          Decimal.parse(val.toString()).formatDisplayablePrice(
                        locale: DeviceLocale.localeOf(context),
                        currency: fiatCurrency,
                        skipSymbol: true,
                      );

                      return Center(
                        child: Text(
                          formattedValue,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineTouchData: LineTouchData(
                enabled: true,
                touchCallback: (event, lineResponse) {
                  final selectedIndex =
                      lineResponse?.lineBarSpots?.first.spotIndex;

                  if (selectedIndex == null ||
                      event is FlTapUpEvent ||
                      event is FlLongPressEnd) {
                    onSelect(null);
                  } else {
                    onSelect(data[selectedIndex]);
                  }
                },
                getTouchedSpotIndicator: (_, indicators) =>
                    indicators.map((_) => _touchedSpotIndicatorData).toList(),
                touchTooltipData: _createTooltipData(),
                getTouchLineEnd: (barData, spotIndex) => double.infinity,
              ),
            ),
            swapAnimationDuration: Duration.zero,
          ),
        ],
      ),
    );
  }
}

class _ChartRangeSelector extends StatelessWidget {
  const _ChartRangeSelector({
    required this.onItemSelected,
    required this.interval,
  });

  final ValueSetter<ChartInterval> onItemSelected;
  final ChartInterval interval;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: ChartInterval.values
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
                    color: interval == e ? CpColors.darkBackgroundColor : null,
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
      );
}

extension ChartIntervalExt on ChartInterval {
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

  String get timeFrameLabel {
    switch (this) {
      case ChartInterval.oneDay:
        return 'Past Day';
      case ChartInterval.oneWeek:
        return 'Past Week';
      case ChartInterval.oneMonth:
        return 'Past Month';
      case ChartInterval.threeMonth:
        return 'Past Three Months';
      case ChartInterval.oneYear:
        return 'Past Year';
      case ChartInterval.all:
        return 'All';
    }
  }
}

const _border = Border.symmetric(
  horizontal: BorderSide(
    color: Color(0xff3A3A3A),
    width: 1,
  ),
);

class _ChartBackground extends StatelessWidget {
  const _ChartBackground();

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xff222020),
          border: _border,
        ),
      );
}

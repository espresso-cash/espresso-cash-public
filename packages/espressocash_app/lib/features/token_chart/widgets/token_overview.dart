import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/user_preferences.dart';
import '../src/bloc.dart';
import 'token_chart.dart';

export '../src/token_chart_item.dart';

class ChartPriceOverview extends StatelessWidget {
  const ChartPriceOverview({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TokenChartBloc, TokenChartState>(
        builder: (context, state) {
          final isLoading = state.processingState.isProcessing;

          final data = state.chart;

          if (isLoading || data.isEmpty) {
            return const Text('', style: TextStyle(fontSize: 13));
          }

          final first = data.first.price ?? 0;
          final last = data.last.price ?? 0;

          final valueChange = last - first;
          final percentageChange = ((last - first) / first) * 100;

          return _PriceOverviewWidget(
            value: valueChange,
            percent: percentageChange,
            timeFrame: state.interval.timeFrameLabel(context),
          );
        },
      );
}

class _PriceOverviewWidget extends StatelessWidget {
  const _PriceOverviewWidget({
    required this.value,
    required this.percent,
    required this.timeFrame,
  });

  final double value;
  final double percent;
  final String timeFrame;

  @override
  Widget build(BuildContext context) {
    final fiatCurrency = context.watch<UserPreferences>().fiatCurrency;

    final isNegative = value.isNegative;
    final prefix = isNegative ? '-' : '';
    final sign = fiatCurrency.sign;

    return Text.rich(
      TextSpan(
        text:
            '$prefix$sign${value.abs().toStringAsFixed(2)} (${percent.abs().toStringAsFixed(2)}%)',
        children: [
          TextSpan(
            text: ' $timeFrame',
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
      style: TextStyle(
        color: isNegative ? const Color(0xffFF6640) : const Color(0xff48AC1F),
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';
import 'token_chart.dart';

export '../token_chart_item.dart';

class TokenOverview extends StatelessWidget {
  const TokenOverview({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TokenChartBloc, TokenChartState>(
        builder: (context, state) {
          final isLoading = state.processingState.isProcessing;

          final data = state.chart;

          if (isLoading || data.isEmpty) {
            return const Text('');
          }

          final first = data.first.price ?? 0;
          final last = data.last.price ?? 0;

          final valueChange = last - first;
          final percentageChange = ((last - first) / first) * 100;

          return _Text(
            value: valueChange,
            percent: percentageChange,
            timeFrame: state.interval.timeFrameLabel,
          );
        },
      );
}

class _Text extends StatelessWidget {
  const _Text({
    required this.value,
    required this.percent,
    required this.timeFrame,
  });

  final double value;
  final double percent;
  final String timeFrame;

  @override
  Widget build(BuildContext context) {
    final isNegative = value.isNegative;
    final prefix = isNegative ? '-' : '';
    const currency = r'$';

    return Text.rich(
      TextSpan(
        text:
            '$prefix$currency${value.abs().toStringAsFixed(2)} (${percent.abs().toStringAsFixed(2)}%)',
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

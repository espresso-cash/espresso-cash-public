part of 'token_chart_bloc.dart';

@freezed
class TokenChartEvent with _$TokenChartEvent {
  const factory TokenChartEvent.chartRequested({
    ChartInterval? interval,
  }) = FetchChartRequested;
}

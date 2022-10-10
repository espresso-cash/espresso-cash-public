part of 'token_chart_bloc.dart';

@freezed
class TokenChartState
    with _$TokenChartState
    implements StateWithProcessingState {
  const factory TokenChartState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    @Default([]) List<TokenChartItem> chart,
    required ChartInterval interval,
  }) = _TokenChartState;
}

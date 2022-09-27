part of 'token_info_bloc.dart';

@freezed
class TokenInfoState with _$TokenInfoState implements StateWithProcessingState {
  const factory TokenInfoState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    @Default([]) List<TokenChartItem> chart,
  }) = _TokenInfoState;
}

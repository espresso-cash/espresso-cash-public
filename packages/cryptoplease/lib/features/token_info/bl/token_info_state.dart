part of 'token_info_bloc.dart';

@freezed
class TokenInfoState with _$TokenInfoState implements StateWithProcessingState {
  const factory TokenInfoState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    String? name,
    String? description,
    int? marketCap,
    String? homePage,
  }) = _TokenInfoState;
}

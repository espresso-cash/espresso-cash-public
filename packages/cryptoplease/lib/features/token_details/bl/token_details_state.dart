part of 'token_details_bloc.dart';

@freezed
class TokenDetailState
    with _$TokenDetailState
    implements StateWithProcessingState {
  const factory TokenDetailState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    String? name,
    String? description,
    int? marketCap,
  }) = _TokenDetailsState;
}

part of 'conversion_rates_bloc.dart';

@freezed
class ConversionRatesState
    with _$ConversionRatesState
    implements StateWithProcessingState {
  const factory ConversionRatesState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
  }) = _ConversionRatesState;
}

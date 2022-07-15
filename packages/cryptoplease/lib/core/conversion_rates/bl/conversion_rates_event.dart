part of 'conversion_rates_bloc.dart';

@freezed
class ConversionRatesEvent with _$ConversionRatesEvent {
  const factory ConversionRatesEvent.refreshRequested({
    required FiatCurrency currency,
    required Iterable<Token> tokens,
  }) = RefreshRequested;
}

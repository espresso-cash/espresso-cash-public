part of 'swap_selector_bloc.dart';

@freezed
class SwapSelectorEvent with _$SwapSelectorEvent {
  const factory SwapSelectorEvent.init() = Init;

  const factory SwapSelectorEvent.inputUpdated(Token token) = InputUpdated;

  const factory SwapSelectorEvent.outputUpdated(Token token) = OutputUpdated;

  const factory SwapSelectorEvent.amountUpdated(Decimal decimal) =
      AmountUpdated;

  const factory SwapSelectorEvent.slippageUpdated(Decimal slippage) =
      SlippageUpdated;

  const factory SwapSelectorEvent.outputInvalidated() = OutputInvalidated;

  const factory SwapSelectorEvent.swapInverted() = SwapInverted;

  const factory SwapSelectorEvent.submitted() = Submitted;
}

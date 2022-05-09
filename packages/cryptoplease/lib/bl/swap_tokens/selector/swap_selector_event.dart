part of 'swap_selector_bloc.dart';

@freezed
class SwapSelectorEvent with _$SwapSelectorEvent {
  const factory SwapSelectorEvent.initialized() = SwapSelectorLoadEvent;

  const factory SwapSelectorEvent.inputSelected(Token inputToken) =
      SwapSelectorInputEvent;

  const factory SwapSelectorEvent.outputSelected(Token outputToken) =
      SwapSelectorOutputEvent;

  const factory SwapSelectorEvent.amountUpdated(Decimal decimal) =
      SwapSelectorAmountEvent;

  const factory SwapSelectorEvent.slippageUpdated(Decimal slippage) =
      SwapSelectorSlippageEvent;
}

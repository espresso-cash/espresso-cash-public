part of 'create_swap_bloc.dart';

@freezed
class CreateSwapEvent with _$CreateSwapEvent {
  const factory CreateSwapEvent.amountUpdated(Decimal decimal) = AmountUpdated;

  const factory CreateSwapEvent.editingModeToggled() = EditingModeToggled;

  const factory CreateSwapEvent.slippageUpdated(Slippage slippage) =
      SlippageUpdated;

  const factory CreateSwapEvent.submitted() = Submitted;

  const factory CreateSwapEvent.routeInvalidated() = RouteInvalidated;
}

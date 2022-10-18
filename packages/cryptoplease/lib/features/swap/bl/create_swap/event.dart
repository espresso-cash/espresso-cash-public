part of 'bloc.dart';

@freezed
class CreateSwapEvent with _$CreateSwapEvent {
  const factory CreateSwapEvent.initialized(
    Token input,
    Token output,
    Decimal slippage,
  ) = Init;

  const factory CreateSwapEvent.inputUpdated(Decimal decimal) = InputUpdated;

  const factory CreateSwapEvent.outputUpdated(Decimal decimal) = OutputUpdated;

  const factory CreateSwapEvent.slippageUpdated(Decimal slippage) =
      SlippageUpdated;

  const factory CreateSwapEvent.submitted() = Submitted;

  const factory CreateSwapEvent.routeInvalidated() = RouteInvalidated;
}

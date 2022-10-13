part of 'bloc.dart';

@freezed
class CreateSwapEvent with _$CreateSwapEvent {
  const factory CreateSwapEvent.init(
    Token input,
    Token output,
    Decimal slippage,
  ) = Init;

  const factory CreateSwapEvent.outputUpdated(Token token) = OutputUpdated;

  const factory CreateSwapEvent.amountUpdated(Decimal decimal) = AmountUpdated;

  const factory CreateSwapEvent.slippageUpdated(Decimal slippage) =
      SlippageUpdated;

  const factory CreateSwapEvent.outputInvalidated() = OutputInvalidated;

  const factory CreateSwapEvent.submitted() = Submitted;
}

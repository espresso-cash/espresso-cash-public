part of 'swap_selector_bloc.dart';

@freezed
class SwapSelectorState with _$SwapSelectorState {
  factory SwapSelectorState({
    required Amount amount,
    required Decimal slippage,
    @Default(Iterable<Token>.empty()) Iterable<Token> inputTokens,
    @Default(Iterable<Token>.empty()) Iterable<Token> outputTokens,
    Token? selectedInput,
    Token? selectedOutput,
    @Default(ProcessingState.none()) ProcessingState processingState,
  }) = _SwapSelectorState;

  const SwapSelectorState._();

  bool get canSwap =>
      amount.value != 0 && selectedInput != null && selectedOutput != null;
}

part of 'swap_selector_bloc.dart';

@freezed
class SwapSelectorState with _$SwapSelectorState {
  const factory SwapSelectorState({
    required Amount amount,
    @Default(Iterable<Token>.empty()) Iterable<Token> inputTokens,
    @Default(Iterable<Token>.empty()) Iterable<Token> outputTokens,
    @Default(1.0) double slippage,
    Token? selectedInput,
    Token? selectedOutput,
    @Default(false) bool isLoading,
  }) = _SwapSelectorState;

  const SwapSelectorState._();

  bool get canSwap =>
      amount.value != 0 && selectedInput != null && selectedOutput != null;
}

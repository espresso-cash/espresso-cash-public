part of 'swap_selector_bloc.dart';

@freezed
class SwapSelectorState with _$SwapSelectorState {
  const factory SwapSelectorState({
    @Default(Iterable<Token>.empty()) Iterable<Token> inputTokens,
    @Default(Iterable<Token>.empty()) Iterable<Token> outputTokens,
    Token? selectedInput,
    Token? selectedOutput,
    @Default(false) bool isLoading,
  }) = _SwapSelectorState;

  const SwapSelectorState._();
}

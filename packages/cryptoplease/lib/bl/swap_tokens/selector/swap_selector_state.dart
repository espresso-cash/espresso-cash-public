part of 'swap_selector_bloc.dart';

@freezed
class SwapSelectorState with _$SwapSelectorState {
  factory SwapSelectorState({
    required CryptoAmount amount,
    required Decimal slippage,
    @Default(Iterable<Token>.empty()) Iterable<Token> inputTokens,
    @Default(Iterable<Token>.empty()) Iterable<Token> outputTokens,
    Token? selectedInput,
    Token? selectedOutput,
    JupiterRoute? bestRoute,
    @Default(ProcessingState<SwapExcetion>.none())
        ProcessingState<SwapExcetion> processingState,
  }) = _SwapSelectorState;

  const SwapSelectorState._();

  bool get canSwap =>
      bestRoute != null && selectedInput != null && selectedOutput != null;
}

extension ConvertedAmountExtension on SwapSelectorState {
  CryptoAmount? get convertedAmount {
    final route = bestRoute;
    final token = selectedOutput;
    if (route == null || token == null) return null;

    return CryptoAmount(
      value: route.outAmount,
      currency: CryptoCurrency(token: token),
    );
  }
}

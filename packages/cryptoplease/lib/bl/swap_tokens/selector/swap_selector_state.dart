part of 'swap_selector_bloc.dart';

@freezed
class SwapSelectorState with _$SwapSelectorState {
  const factory SwapSelectorState.uninitialized() = Uninitialized;

  const factory SwapSelectorState.initialized({
    required CryptoAmount amount,
    required Decimal slippage,
    required Iterable<Token> inputTokens,
    required Iterable<Token> outputTokens,
    required Token output,
    required JupiterIndexedRouteMap routeMap,
    JupiterRoute? bestRoute,
    @Default(ProcessingState<SwapException>.none())
        ProcessingState<SwapException> processingState,
  }) = Initialized;

  const factory SwapSelectorState.failure() = Failure;

  const factory SwapSelectorState.success(JupiterRoute route) = Success;

  const SwapSelectorState._();
}

extension SwapSelectorStateExt on SwapSelectorState {
  CryptoAmount? get convertedAmount => maybeMap(
        initialized: (s) {
          final route = s.bestRoute;
          if (route == null) return null;

          return CryptoAmount(
            value: route.outAmount,
            currency: CryptoCurrency(token: s.output),
          );
        },
        orElse: () => null,
      );

  Token? get input => maybeMap(
        initialized: (s) => s.amount.currency.token,
        orElse: () => null,
      );

  Token? get output => maybeMap(
        initialized: (s) => s.output,
        orElse: () => null,
      );

  bool get isLoadingRoute => maybeMap(
        initialized: (s) => s.processingState is ProcessingStateProcessing,
        orElse: F,
      );

  Iterable<Token> get inputTokens => maybeMap(
        initialized: (s) => s.inputTokens,
        orElse: () => const [],
      );

  Iterable<Token> get outputTokens => maybeMap(
        initialized: (s) => s.outputTokens,
        orElse: () => const [],
      );

  JupiterRoute? get bestRoute => maybeMap(
        initialized: (s) => s.bestRoute,
        orElse: () => null,
      );

  ProcessingState<SwapException>? get routeProcessingState => maybeMap(
        initialized: (s) => s.processingState,
        orElse: () => null,
      );

  CryptoAmount? get outputAmount {
    final route = bestRoute;
    final token = output;
    if (route == null || token == null) return null;

    return CryptoAmount(
      value: route.outAmount,
      currency: CryptoCurrency(token: token),
    );
  }

  Decimal? get slippage => maybeMap(
        initialized: (s) => s.slippage,
        orElse: () => null,
      );

  bool get canSwap => outputAmount != null;
}

extension InitialzedExt on Initialized {
  Token get input => amount.token;
}

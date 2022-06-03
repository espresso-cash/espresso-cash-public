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

  const SwapSelectorState._();
}

extension SwapSelectorStateExt on SwapSelectorState {
  CryptoAmount? get convertedAmount => this.map(
        uninitialized: (_) => null,
        failure: (_) => null,
        initialized: (s) {
          final route = s.bestRoute;
          if (route == null) return null;

          return CryptoAmount(
            value: route.outAmount,
            currency: CryptoCurrency(token: s.output),
          );
        },
      );

  Token? get input => this.map(
        uninitialized: (_) => null,
        failure: (_) => null,
        initialized: (s) => s.amount.currency.token,
      );

  Token? get output => this.map(
        uninitialized: (_) => null,
        failure: (_) => null,
        initialized: (s) => s.output,
      );

  bool get isLoadingRoute => this.map(
        uninitialized: F,
        failure: F,
        initialized: (s) => s.processingState is ProcessingStateProcessing,
      );

  Iterable<Token> get inputTokens => this.map(
        uninitialized: (_) => const [],
        failure: (_) => const [],
        initialized: (s) => s.inputTokens,
      );

  Iterable<Token> get outputTokens => this.map(
        uninitialized: (_) => const [],
        failure: (_) => const [],
        initialized: (s) => s.outputTokens,
      );

  JupiterRoute? get bestRoute => this.map(
        uninitialized: (_) => null,
        failure: (_) => null,
        initialized: (s) => s.bestRoute,
      );

  ProcessingState<SwapException>? get routeProcessingState => this.map(
        uninitialized: (_) => null,
        failure: (_) => null,
        initialized: (s) => s.processingState,
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

  Decimal? get slippage => this.map(
        uninitialized: (_) => null,
        failure: (_) => null,
        initialized: (s) => s.slippage,
      );

  bool get canSwap => outputAmount != null;
}

extension InitialzedExt on Initialized {
  Token get input => amount.token;
}

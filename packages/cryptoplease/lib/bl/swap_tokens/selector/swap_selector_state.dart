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

extension InitializedExt on Initialized {
  Token get input => amount.token;

  Either<SwapException, JupiterRoute> validate(IMap<Token, Amount> balances) {
    final token = amount.token;
    final tokenBalance = balances.balanceFromToken(token);
    final fee = _calculateFee();

    // Check if the total amount doesn't exceed the user's balance.
    final totalAmount = amount.token == Token.wrappedSol
        ? amount + fee as CryptoAmount
        : amount;
    if (tokenBalance < totalAmount) {
      return Either.left(
        SwapException.insufficientBalance(
          balance: tokenBalance,
          amount: totalAmount,
        ),
      );
    }

    // Check if the user has enough SOL balance to pay the fee. If the outgoing
    // token is SOL, it will always succeed since the total amount was checked
    // before, but for other tokens, we need to check the fee as the fee is
    // always paid in SOL.
    final solBalance = balances.balanceFromToken(Token.sol);
    if (solBalance < fee) {
      return Either.left(SwapException.insufficientFee(fee: fee));
    }

    final route = bestRoute;
    if (route == null) {
      return const Either.left(SwapException.routeNotFound());
    }

    return Either.right(route);
  }

  /// Calculates max swap amount for the selected token.
  ///
  /// It takes into account the fee, so for SOL the maximum possible amount is
  /// lesser than the user's balance.
  CryptoAmount calculateMaxAmount(IMap<Token, Amount> balances) {
    final balance = balances.balanceFromToken(amount.token);

    return amount.token == Token.wrappedSol
        ? balance - _calculateFee() as CryptoAmount
        : balance;
  }

  CryptoAmount _calculateFee() {
    const baseFee = lamportsPerSignature + tokenProgramRent;

    // Base fee for the transaction multiplied by 3 since it's the max of
    // transactions that might happen
    final fee = amount.token == Token.wrappedSol ? baseFee * 3 : baseFee;

    return CryptoAmount(value: fee, currency: Currency.sol);
  }
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

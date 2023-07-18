part of 'create_swap_bloc.dart';

@freezed
class SwapEditingMode with _$SwapEditingMode {
  const factory SwapEditingMode.input() = _InputSwapMode;
  const factory SwapEditingMode.output() = _OutputSwapMode;
}

@freezed
class CreateSwapState with _$CreateSwapState {
  const factory CreateSwapState({
    required CryptoAmount inputAmount,
    required CryptoAmount outputAmount,
    required Slippage slippage,
    required SwapEditingMode editingMode,
    SwapRoute? bestRoute,
    DateTime? expiresAt,
    @Default(Flow<CreateSwapException, SwapRoute>.initial())
    Flow<CreateSwapException, SwapRoute> flowState,
  }) = Initialized;
}

extension CreateSwapExt on CreateSwapState {
  CryptoAmount get fee =>
      bestRoute?.fee ??
      const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  Token get input => inputAmount.token;
  Token get output => outputAmount.token;

  Token get requestToken => requestAmount.token;

  CryptoAmount get requestAmount => editingMode.map(
        input: always(inputAmount),
        output: always(outputAmount),
      );

  Either<CreateSwapException, SwapRoute> validate(
    IMap<Token, Amount> balances,
  ) {
    final tokenBalance = balances.balanceFromToken(input);

    // Check if the total amount doesn't exceed the user's balance.
    final totalAmount =
        input == Token.usdc ? inputAmount + fee as CryptoAmount : inputAmount;
    if (tokenBalance < totalAmount) {
      return Either.left(
        CreateSwapException.insufficientBalance(
          balance: tokenBalance,
          amount: totalAmount,
        ),
      );
    }

    // Check if the user has enough USDC balance to pay the fee. If the outgoing
    // token is USDC, it will always succeed since the total amount was checked
    // before, but for other tokens, we need to check the fee as the fee is
    // always paid in USDC.
    final usdcBalance = balances.balanceFromToken(Token.usdc);
    if (usdcBalance < fee) {
      return Either.left(CreateSwapException.insufficientFee(fee: fee));
    }

    final route = bestRoute;

    return route == null
        ? const Either.left(CreateSwapException.routeNotFound())
        : Either.right(route);
  }
}

@freezed
class CreateSwapException with _$CreateSwapException implements Exception {
  const factory CreateSwapException.other(Exception e) = OtherException;

  const factory CreateSwapException.routeNotFound() = RouteNotFound;

  const factory CreateSwapException.insufficientBalance({
    required CryptoAmount balance,
    required CryptoAmount amount,
  }) = InsufficientBalance;

  const factory CreateSwapException.insufficientFee({
    required CryptoAmount fee,
  }) = InsufficientFee;
}

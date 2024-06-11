part of 'create_swap_bloc.dart';

@freezed
class CreateSwapState with _$CreateSwapState {
  const factory CreateSwapState({
    required CryptoAmount inputAmount,
    required CryptoAmount outputAmount,
    required Slippage slippage,
    SwapRoute? bestRoute,
    DateTime? expiresAt,
    @Default(Flow<CreateSwapException, SwapRoute>.initial())
    Flow<CreateSwapException, SwapRoute> flowState,
  }) = Initialized;
}

extension CreateSwapExt on CreateSwapState {
  CryptoAmount get fee =>
      bestRoute?.fee ??
      const CryptoAmount(
        value: 0,
        cryptoCurrency: Currency.usdc,
      ); //TODO update fees to be in SOL

  Token get input => inputAmount.token;
  Token get output => outputAmount.token;
  Token get requestToken => requestAmount.token;

  CryptoAmount get requestAmount => inputAmount;

  Either<CreateSwapException, SwapRoute> validate(
    IList<CryptoAmount> balances,
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

    // TODOcheck if user has enough SOL fee

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

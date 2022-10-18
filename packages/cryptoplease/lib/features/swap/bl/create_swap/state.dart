part of 'bloc.dart';

enum SwapEditingMode { input, output }

@freezed
class CreateSwapState with _$CreateSwapState {
  const factory CreateSwapState({
    required CryptoAmount inputAmount,
    required CryptoAmount outputAmount,
    required Decimal slippage,
    @Default(SwapEditingMode.input) SwapEditingMode editingMode,
    JupiterRoute? bestRoute,
    @Default(Flow<SwapException, JupiterRoute>.initial())
        Flow<SwapException, JupiterRoute> flowState,
  }) = Initialized;
}

extension InitializedExt on CreateSwapState {
  Token get input => inputAmount.token;
  Token get output => outputAmount.token;

  Token get requestToken => requestAmount.token;

  CryptoAmount get requestAmount =>
      editingMode == SwapEditingMode.input ? inputAmount : outputAmount;

  SwapMode get swapMode => editingMode == SwapEditingMode.input
      ? SwapMode.exactIn
      : SwapMode.exactOut;

  Either<SwapException, JupiterRoute> validate(IMap<Token, Amount> balances) {
    final tokenBalance = balances.balanceFromToken(input);
    final fee = _calculateFee();

    // Check if the total amount doesn't exceed the user's balance.
    final totalAmount = input == Token.wrappedSol
        ? inputAmount + fee as CryptoAmount
        : inputAmount;
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

  CryptoAmount _calculateFee() {
    const baseFee = lamportsPerSignature + tokenProgramRent;

    // Base fee for the transaction multiplied by 3 since it's the max of
    // transactions that might happen
    final fee = input == Token.sol ? baseFee * 3 : baseFee;

    return CryptoAmount(value: fee, currency: Currency.sol);
  }
}

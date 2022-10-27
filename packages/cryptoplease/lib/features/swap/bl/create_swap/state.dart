part of 'bloc.dart';

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
    required Decimal slippage,
    @Default(SwapEditingMode.input()) SwapEditingMode editingMode,
    JupiterRoute? bestRoute,
    @Default(Flow<SwapException, JupiterRoute>.initial())
        Flow<SwapException, JupiterRoute> flowState,
  }) = Initialized;
}

extension CreateSwapExt on CreateSwapState {
  Token get input => inputAmount.token;
  Token get output => outputAmount.token;

  Token get requestToken => requestAmount.token;

  CryptoAmount get requestAmount => editingMode.map(
        input: always(inputAmount),
        output: always(outputAmount),
      );

  Either<SwapException, JupiterRoute> validate(IMap<Token, Amount> balances) {
    final tokenBalance = balances.balanceFromToken(input);

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

  CryptoAmount get fee {
    // TODO(rhbrunetto): fee (in USDC) will be retrieved after user submit
    final routeFee = bestRoute?.fees;
    const zeroFee = CryptoAmount(value: 0, currency: Currency.sol);

    if (routeFee == null) return zeroFee;

    /// Jupiter v3 returns the fee on route if userPublicKey is provided
    return zeroFee.copyWith(
      value: routeFee.totalFeeAndDeposits.toInt(),
    );
  }
}

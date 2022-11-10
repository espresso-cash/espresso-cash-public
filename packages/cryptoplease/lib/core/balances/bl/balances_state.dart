part of 'balances_bloc.dart';

@freezed
class BalancesState with _$BalancesState implements StateWithProcessingState {
  const factory BalancesState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    @Default(<Token, Amount>{}) Map<Token, Amount> balances,
  }) = _BalancesState;
}

extension BalancesStateExt on BalancesState {
  Set<Token> get userTokens => {...balances.keys, Token.sol, Token.usdc};

  Set<Token> get userTokensFiltered => {
        ...balances.entries.where((e) => e.value.value != 0).map((e) => e.key),
        Token.sol,
        Token.usdc
      };

  Set<Token> get stableTokens =>
      userTokens.where((t) => t.isStablecoin).toSet();

  Set<Token> get nonStableTokens =>
      userTokens.whereNot((t) => t.isStablecoin).toSet();
}

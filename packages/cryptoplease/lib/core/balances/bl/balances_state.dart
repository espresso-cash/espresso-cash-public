part of 'balances_bloc.dart';

@freezed
class BalancesState with _$BalancesState implements StateWithProcessingState {
  factory BalancesState({
    @Default(ProcessingStateNone()) ProcessingState processingState,
    @Default(<Token, Amount>{}) Map<Token, Amount> balances,
  }) = _BalancesState;

  BalancesState._();

  late final Set<Token> userTokens = {...balances.keys, Token.sol, Token.usdc};

  late final Set<Token> userTokensWithPositiveBalance = {
    ...balances.entries.where((e) => e.value.value >= 0.001).map((e) => e.key),
    Token.sol,
    Token.usdc
  };

  late final Set<Token> stableTokens =
      userTokens.where((t) => t.isStablecoin).toSet();

  late final Set<Token> nonStableTokens =
      userTokens.whereNot((t) => t.isStablecoin).toSet();
}

part of 'swap_transaction_bloc.dart';

@freezed
class SwapTransactionState with _$SwapTransactionState {
  const factory SwapTransactionState.idle() = _SwapIdle;

  const factory SwapTransactionState.preparing() = _SwapPreparing;

  const factory SwapTransactionState.settingUp(JupiterSwapTransactions tx) =
      _SwapSetup;

  const factory SwapTransactionState.swapping(JupiterSwapTransactions tx) =
      _SwapSwap;

  const factory SwapTransactionState.cleaningUp(JupiterSwapTransactions tx) =
      _SwapCleanUp;

  const factory SwapTransactionState.finished() = _SwapFinished;

  const factory SwapTransactionState.failed(SwapException error) = _SwapFailed;

  const SwapTransactionState._();
}

part of 'swap_transaction_bloc.dart';

@freezed
class SwapTransactionState with _$SwapTransactionState {
  const factory SwapTransactionState.idle() = Idle;

  const factory SwapTransactionState.preparing() = Preparing;

  const factory SwapTransactionState.settingUp(JupiterSwapTransactions tx) =
      SettingUp;

  const factory SwapTransactionState.swapping(JupiterSwapTransactions tx) =
      Swapping;

  const factory SwapTransactionState.cleaningUp(JupiterSwapTransactions tx) =
      CleaningUp;

  const factory SwapTransactionState.finished() = Finished;

  const factory SwapTransactionState.failed(SwapException error) = Failed;

  const SwapTransactionState._();
}

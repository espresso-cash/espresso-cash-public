part of 'swap_transaction_bloc.dart';

@freezed
class SwapTransactionState with _$SwapTransactionState {
  const factory SwapTransactionState.idle() = _SwapIdle;

  const factory SwapTransactionState.preparing() = _SwapPreparing;

  const factory SwapTransactionState.settingUp() = _SwapSetup;

  const factory SwapTransactionState.swapping() = _SwapSwap;

  const factory SwapTransactionState.cleaningUp() = _SwapCleanUp;

  const factory SwapTransactionState.finished() = _SwapFinished;

  const factory SwapTransactionState.failed(
    SwapFailReason reason,
    Exception? error,
  ) = _SwapFailed;

  const SwapTransactionState._();
}

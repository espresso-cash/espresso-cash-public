part of 'swap_transaction_bloc.dart';

@freezed
class SwapTransactionEvent with _$SwapTransactionEvent {
  const factory SwapTransactionEvent.swapRequested({
    required JupiterRoute jupiterRoute,
  }) = SwapRequested;

  const factory SwapTransactionEvent.retryRequested() = RetryRequested;
}

part of 'swap_transaction_bloc.dart';

@freezed
class SwapTransactionEvent with _$SwapTransactionEvent {
  const factory SwapTransactionEvent.swap({
    required JupiterRoute jupiterRoute,
  }) = SwapEvent;
}

part of 'swap_transaction_bloc.dart';

@freezed
class SwapTransactionEvent with _$SwapTransactionEvent {
  const factory SwapTransactionEvent.swap({
    required Token inputToken,
    required Token outputToken,
    required Amount amount,
    required Decimal slippage,
  }) = SwapEvent;
}

part of 'swap_transaction_bloc.dart';

typedef SwapTransferId = String;

@freezed
class SwapTransactionState with _$SwapTransactionState {
  const factory SwapTransactionState({
    @Default(FlowInitial<Exception, SwapTransferId>())
        Flow<Exception, SwapTransferId> flow,
  }) = _SwapTransactionState;

  const SwapTransactionState._();
}

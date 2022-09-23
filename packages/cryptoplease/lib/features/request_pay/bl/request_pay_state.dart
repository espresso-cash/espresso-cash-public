part of 'request_pay_bloc.dart';

@freezed
class RequestPayState with _$RequestPayState {
  const factory RequestPayState({
    required CryptoAmount amount,
    String? recipient,
    DirectTransferState? directTransfer,
    @Default(ProcessingState.none()) ProcessingState processingState,
  }) = _RequestPayState;

  const RequestPayState._();

  CryptoAmount get fee =>
      directTransfer?.fee ??
      calculateFee(
        SplitKeyApiVersion.v2,
        OutgoingTransferType.splitKey,
        amount.currency.token.address,
      );
}

@freezed
class DirectTransferState with _$DirectTransferState {
  const factory DirectTransferState({
    required OutgoingTransferId paymentId,
    required CryptoAmount fee,
  }) = _DirectTransferState;

  const DirectTransferState._();
}

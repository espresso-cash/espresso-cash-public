part of 'request_pay_bloc.dart';

@freezed
class RequestPayState with _$RequestPayState {
  const factory RequestPayState({
    required CryptoAmount amount,
  }) = _RequestPayState;

  const RequestPayState._();

  CryptoAmount get fee => calculateFee(
        SplitKeyApiVersion.v2,
        OutgoingTransferType.splitKey,
        amount.currency.token.address,
      );
}

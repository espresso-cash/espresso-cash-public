part of 'request_pay_bloc.dart';

@freezed
class RequestPayState with _$RequestPayState {
  const factory RequestPayState({
    required CryptoAmount amount,
  }) = _RequestPayState;

  const RequestPayState._();

  Amount get fee => calculateFee(
        OutgoingTransferType.splitKey,
        amount.currency.token.address,
      );
}

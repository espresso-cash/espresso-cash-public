part of 'request_pay_bloc.dart';

@freezed
class RequestPayEvent with _$RequestPayEvent {
  const factory RequestPayEvent.tokenUpdated(Token token) = _TokenUpdated;

  const factory RequestPayEvent.amountUpdated(Decimal amount) = _AmountUpdated;
}

part of 'request_pay_bloc.dart';

@freezed
class RequestPayEvent with _$RequestPayEvent {
  const factory RequestPayEvent.amountUpdated(Decimal amount) = _AmountUpdated;
}

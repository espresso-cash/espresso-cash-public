part of 'request_pay_bloc.dart';

@freezed
class RequestPayEvent with _$RequestPayEvent {
  const factory RequestPayEvent.amountUpdated(Decimal amount) = _AmountUpdated;
  const factory RequestPayEvent.recipientUpdated(String recipient) =
      _RecipientUpdated;
  const factory RequestPayEvent.cleared() = _Cleared;
}

part of 'confirm_payment_bloc.dart';

@freezed
class ConfirmPaymentEvent with _$ConfirmPaymentEvent {
  const factory ConfirmPaymentEvent.confirmed() = Confirmed;

  const factory ConfirmPaymentEvent.invalidated() = Invalidated;
}

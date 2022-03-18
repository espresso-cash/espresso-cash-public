part of 'bloc.dart';

@freezed
class SplitKeyIncomingPaymentEvent with _$SplitKeyIncomingPaymentEvent {
  const factory SplitKeyIncomingPaymentEvent.firstPartAdded({
    required SplitKeyIncomingFirstPart firstPart,
  }) = FirstPartAdded;

  const factory SplitKeyIncomingPaymentEvent.secondPartAdded({
    required SplitKeySecondLink value,
  }) = SecondPartAdded;

  const factory SplitKeyIncomingPaymentEvent.paymentRequested({
    required String recipient,
  }) = PaymentRequested;

  const factory SplitKeyIncomingPaymentEvent.cleared() = PaymentCleared;
}

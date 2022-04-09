part of 'bloc.dart';

@freezed
class CreatePaymentRequestEvent with _$CreatePaymentRequestEvent {
  const factory CreatePaymentRequestEvent.payerNameUpdated(String value) =
      PayerNameUpdated;

  const factory CreatePaymentRequestEvent.submitted({
    required Ed25519HDPublicKey recipient,
  }) = Submitted;
}

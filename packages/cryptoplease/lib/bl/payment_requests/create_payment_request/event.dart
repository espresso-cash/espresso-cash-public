part of 'bloc.dart';

@freezed
class CreatePaymentRequestEvent with _$CreatePaymentRequestEvent {
  const factory CreatePaymentRequestEvent.payerNameUpdated(String value) =
      PayerNameUpdated;

  const factory CreatePaymentRequestEvent.tokenAmountUpdated(
    Decimal amount,
  ) = TokenAmountUpdated;

  const factory CreatePaymentRequestEvent.fiatAmountUpdated(
    Decimal amount,
  ) = FiatAmountUpdated;

  const factory CreatePaymentRequestEvent.tokenUpdated(Token token) =
      TokenUpdated;

  const factory CreatePaymentRequestEvent.submitted({
    required Ed25519HDPublicKey recipient,
  }) = Submitted;
}

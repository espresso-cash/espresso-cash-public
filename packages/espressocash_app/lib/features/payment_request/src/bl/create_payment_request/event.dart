part of 'bloc.dart';

@freezed
class CreatePaymentRequestEvent with _$CreatePaymentRequestEvent {
  const factory CreatePaymentRequestEvent.labelUpdated(String value) =
      LabelUpdated;

  const factory CreatePaymentRequestEvent.tokenAmountUpdated(
    Decimal amount,
  ) = TokenAmountUpdated;

  const factory CreatePaymentRequestEvent.fiatAmountUpdated(
    Decimal amount,
  ) = FiatAmountUpdated;

  const factory CreatePaymentRequestEvent.submitted({
    required Ed25519HDPublicKey recipient,
  }) = Submitted;
}

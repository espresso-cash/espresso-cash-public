part of 'bloc.dart';

@freezed
class PaymentRequestVerifierEvent with _$PaymentRequestVerifierEvent {
  const factory PaymentRequestVerifierEvent.waitingFailed(Exception e) =
      WaitingFailed;

  const factory PaymentRequestVerifierEvent.txAdded(TransactionId id) = TxAdded;

  const factory PaymentRequestVerifierEvent.verificationFailed(
    Exception error, {
    required TransactionId transactionId,
  }) = VerificationFailed;

  const factory PaymentRequestVerifierEvent.suceeded() = Succeeded;
}

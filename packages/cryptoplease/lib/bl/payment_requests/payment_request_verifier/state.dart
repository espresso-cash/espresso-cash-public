part of 'bloc.dart';

@freezed
class PaymentRequestVerifierState with _$PaymentRequestVerifierState {
  const factory PaymentRequestVerifierState.waiting() = Waiting;
  const factory PaymentRequestVerifierState.retrying() = Retrying;
  const factory PaymentRequestVerifierState.verifying() = Verifying;
  const factory PaymentRequestVerifierState.success() = Success;
  const factory PaymentRequestVerifierState.failure() = Failure;
}

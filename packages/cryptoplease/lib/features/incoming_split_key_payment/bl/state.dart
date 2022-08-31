part of 'bloc.dart';

@freezed
class SplitKeyIncomingPayment with _$SplitKeyIncomingPayment {
  const factory SplitKeyIncomingPayment.none() = PaymentNone;

  const factory SplitKeyIncomingPayment.firstPartReady({
    required String firstPart,
    required String tokenAddress,
    required SplitKeyApiVersion apiVersion,
  }) = PaymentFirstPartReady;

  const factory SplitKeyIncomingPayment.secondPartReady({
    required String firstPart,
    required String secondPart,
    required String tokenAddress,
    required SplitKeyApiVersion apiVersion,
    @Default(ProcessingStateNone<SplitKeyIncomingPaymentError>())
        ProcessingState<SplitKeyIncomingPaymentError> processingState,
  }) = PaymentSecondPartReady;

  const factory SplitKeyIncomingPayment.success() = PaymentSuccess;
}

@freezed
class SplitKeyIncomingPaymentError
    with _$SplitKeyIncomingPaymentError
    implements Exception {
  const factory SplitKeyIncomingPaymentError.consumed() = ErrorConsumed;

  const factory SplitKeyIncomingPaymentError.invalidTx() = ErrorInvalidTx;

  const factory SplitKeyIncomingPaymentError.invalidLink() = ErrorInvalidLink;

  const factory SplitKeyIncomingPaymentError.failedToSubmit(SignedTx tx) =
      ErrorFailedToSubmit;

  const factory SplitKeyIncomingPaymentError.failedToConfirm(SignedTx tx) =
      ErrorFailedToConfirm;

  const SplitKeyIncomingPaymentError._();

  bool get isRecoverable => when(
        consumed: F,
        invalidTx: T,
        invalidLink: F,
        failedToSubmit: T,
        failedToConfirm: T,
      );
}

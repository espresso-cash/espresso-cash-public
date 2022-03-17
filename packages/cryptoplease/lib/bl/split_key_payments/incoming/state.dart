part of 'bloc.dart';

@freezed
class SplitKeyIncomingPayment with _$SplitKeyIncomingPayment {
  const factory SplitKeyIncomingPayment.none() = PaymentNone;

  const factory SplitKeyIncomingPayment.firstPartReady({
    required String firstPart,
    required String tokenAddress,
  }) = PaymentFirstPartReady;

  const factory SplitKeyIncomingPayment.secondPartReady({
    required String firstPart,
    required String secondPart,
    required String tokenAddress,
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

  const factory SplitKeyIncomingPaymentError.emptyAccount() = ErrorEmptyAccount;

  const factory SplitKeyIncomingPaymentError.other(Exception error) =
      ErrorOther;
}

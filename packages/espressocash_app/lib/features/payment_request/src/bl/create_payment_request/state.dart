part of 'bloc.dart';

@freezed
class CreatePaymentRequestState with _$CreatePaymentRequestState {
  const factory CreatePaymentRequestState({
    @Default('') String label,
    required CryptoAmount tokenAmount,
    required FiatAmount fiatAmount,
    @Default(Flow<Exception, PaymentRequest>.initial())
    Flow<Exception, PaymentRequest> flow,
  }) = _CreatePaymentRequestState;

  const CreatePaymentRequestState._();

  Token get token => tokenAmount.cryptoCurrency.token;
}

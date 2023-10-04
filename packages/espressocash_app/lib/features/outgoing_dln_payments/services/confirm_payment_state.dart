part of 'confirm_payment_bloc.dart';

@freezed
class ConfirmPaymentState with _$ConfirmPaymentState {
  const factory ConfirmPaymentState({
    PaymentQuote? quote,
    DateTime? expiresAt,
    @Default(Flow<CreateOrderException, PaymentQuote>.initial())
    Flow<CreateOrderException, PaymentQuote> flowState,
  }) = Initialized;
}

@freezed
class CreateOrderException with _$CreateOrderException implements Exception {
  const factory CreateOrderException.other(Exception e) = OtherException;

  const factory CreateOrderException.routeNotFound() = RouteNotFound;

  const factory CreateOrderException.insufficientBalance({
    required CryptoAmount balance,
    required CryptoAmount amount,
  }) = InsufficientBalance;

  const factory CreateOrderException.insufficientFee({
    required CryptoAmount fee,
  }) = InsufficientFee;
}

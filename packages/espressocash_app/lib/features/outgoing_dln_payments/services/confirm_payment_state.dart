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

extension ConfirmPaymentExt on ConfirmPaymentState {
  CryptoAmount get fee =>
      quote?.fee ?? const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  CryptoAmount get inputAmount =>
      quote?.payment.inputAmount ??
      const CryptoAmount(value: 0, cryptoCurrency: Currency.usdc);

  Either<CreateOrderException, PaymentQuote> validate(
    CryptoAmount usdcBalance,
  ) {
    final totalAmount = inputAmount + fee;

    if (usdcBalance < totalAmount) {
      return Either.left(
        CreateOrderException.insufficientBalance(
          balance: usdcBalance,
          amount: totalAmount as CryptoAmount,
        ),
      );
    }

    final route = quote;

    return route == null
        ? const Either.left(CreateOrderException.quoteNotFound())
        : Either.right(route);
  }
}

@freezed
class CreateOrderException with _$CreateOrderException implements Exception {
  const factory CreateOrderException.other(Exception e) = OtherException;

  const factory CreateOrderException.quoteNotFound() = QuoteNotFound;

  const factory CreateOrderException.insufficientBalance({
    required CryptoAmount balance,
    required CryptoAmount amount,
  }) = InsufficientBalance;
}

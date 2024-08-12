import 'package:freezed_annotation/freezed_annotation.dart';

import '../../currency/models/amount.dart';
import 'dln_payment.dart';

part 'payment_quote.freezed.dart';

@freezed
class PaymentQuote with _$PaymentQuote {
  const factory PaymentQuote({
    required DlnPayment payment,
    required CryptoAmount inputAmount,
    required CryptoAmount receiverAmount,
    required CryptoAmount fee,
    required String encodedTx,
    required BigInt slot,
  }) = _PaymentQuote;
}

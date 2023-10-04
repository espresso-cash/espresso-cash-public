import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/amount.dart';
import 'dln_payment.dart';

part 'payment_quote.freezed.dart';

@freezed
class PaymentQuote with _$PaymentQuote {
  const factory PaymentQuote({
    required CryptoAmount receiverAmount,
    required CryptoAmount senderDeductAmount,
    required CryptoAmount fee,
    required String encodedTx,
    required DlnPayment payment,
    required BigInt slot,
  }) = _PaymentQuote;
}

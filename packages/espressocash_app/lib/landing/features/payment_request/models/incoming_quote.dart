import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/amount.dart';

part 'incoming_quote.freezed.dart';

@freezed
class IncomingPaymentQuote with _$IncomingPaymentQuote {
  const factory IncomingPaymentQuote({
    required CryptoAmount inputAmount,
    required CryptoAmount receiverAmount,
    required CryptoAmount fee,
    required String to,
    required String data,
    required int value,
    required int approvalAmount,
    required String usdcErc20Address,
  }) = _IncomingPaymentQuote;
}

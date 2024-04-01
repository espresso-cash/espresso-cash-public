import 'package:espressocash_api/espressocash_api.dart';
import 'package:espressocash_common/dart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'incoming_quote.freezed.dart';

@freezed
class IncomingPaymentQuote with _$IncomingPaymentQuote {
  const factory IncomingPaymentQuote({
    required CryptoAmount inputAmount,
    required CryptoAmount receiverAmount,
    required CryptoAmount fee,
    required QuoteTx tx,
    required QuoteUsdcInfo usdcInfo,
  }) = _IncomingPaymentQuote;
}

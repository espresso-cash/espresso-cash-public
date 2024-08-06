import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_info.freezed.dart';

@freezed
class QuoteInfo with _$QuoteInfo {
  const factory QuoteInfo({
    required String tx,
    required int inputAmount,
    required int senderDeductAmount,
    required int receiverAmount,
    required num totalFees,
  }) = _QuoteInfo;
}

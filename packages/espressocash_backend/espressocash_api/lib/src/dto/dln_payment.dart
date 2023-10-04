import 'package:freezed_annotation/freezed_annotation.dart';

part 'dln_payment.freezed.dart';
part 'dln_payment.g.dart';

@freezed
class PaymentQuoteRequestDto with _$PaymentQuoteRequestDto {
  const factory PaymentQuoteRequestDto({
    required String amount,
    required String senderAddress,
    required String receiverAddress,
    required String receiverBlockchain,
  }) = _PaymentQuoteRequestDto;

  factory PaymentQuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentQuoteRequestDtoFromJson(json);
}

@freezed
abstract class PaymentQuoteResponseDto with _$PaymentQuoteResponseDto {
  const factory PaymentQuoteResponseDto({
    required String senderDeductAmount,
    required String receiverAmount,
    required String encodedTx,
    required int feeInUsdc,
    required BigInt slot,
  }) = _PaymentQuoteResponseDto;

  factory PaymentQuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentQuoteResponseDtoFromJson(json);
}

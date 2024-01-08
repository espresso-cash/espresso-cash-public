import 'package:espressocash_api/espressocash_api.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw.freezed.dart';
part 'withdraw.g.dart';

@freezed
class WithdrawPaymentRequestDto with _$WithdrawPaymentRequestDto {
  const factory WithdrawPaymentRequestDto({
    required String senderAccount,
    required String receiverAccount,
    required int amount,
    required int feePercentage,
    required String rampPartner,
    required String partnerOrderId,
    required Cluster cluster,
  }) = _WithdrawPaymentRequestDto;

  factory WithdrawPaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WithdrawPaymentRequestDtoFromJson(json);
}

@freezed
class WithdrawPaymentResponseDto with _$WithdrawPaymentResponseDto {
  const factory WithdrawPaymentResponseDto({
    required int fee,
    required String transaction,
    required BigInt slot,
  }) = _WithdrawPaymentResponseDto;

  factory WithdrawPaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WithdrawPaymentResponseDtoFromJson(json);
}

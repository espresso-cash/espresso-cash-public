import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
class CreatePaymentRequestDto with _$CreatePaymentRequestDto {
  const factory CreatePaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
    required int amount,
  }) = _CreatePaymentRequestDto;

  factory CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestDtoFromJson(json);
}

@freezed
class CreatePaymentResponseDto with _$CreatePaymentResponseDto {
  const factory CreatePaymentResponseDto({
    required String transaction,
  }) = _CreatePaymentResponseDto;

  factory CreatePaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentResponseDtoFromJson(json);
}

@freezed
class ReceivePaymentRequestDto with _$ReceivePaymentRequestDto {
  const factory ReceivePaymentRequestDto({
    required String receiverAccount,
    required String escrowAccount,
  }) = _ReceivePaymentRequestDto;

  factory ReceivePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReceivePaymentRequestDtoFromJson(json);
}

@freezed
class ReceivePaymentResponseDto with _$ReceivePaymentResponseDto {
  const factory ReceivePaymentResponseDto({
    required String transaction,
  }) = _ReceivePaymentResponseDto;

  factory ReceivePaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReceivePaymentResponseDtoFromJson(json);
}

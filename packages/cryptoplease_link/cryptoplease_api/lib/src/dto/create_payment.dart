import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_payment.freezed.dart';
part 'create_payment.g.dart';

@freezed
class CreatePaymentRequestDto with _$CreatePaymentRequestDto {
  const factory CreatePaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
    required int amount,
    required Cluster cluster,
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
    required Cluster cluster,
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

enum Cluster { mainnet, devnet }

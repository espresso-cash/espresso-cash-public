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
    @Default(false) bool durable,
  }) = _CreatePaymentRequestDto;

  factory CreatePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentRequestDtoFromJson(json);
}

@freezed
class CreatePaymentResponseDto with _$CreatePaymentResponseDto {
  const factory CreatePaymentResponseDto({
    required String transaction,
    required BigInt slot,
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
    @Default(false) bool durable,
  }) = _ReceivePaymentRequestDto;

  factory ReceivePaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ReceivePaymentRequestDtoFromJson(json);
}

@freezed
class ReceivePaymentResponseDto with _$ReceivePaymentResponseDto {
  const factory ReceivePaymentResponseDto({
    required String transaction,
    required BigInt slot,
  }) = _ReceivePaymentResponseDto;

  factory ReceivePaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ReceivePaymentResponseDtoFromJson(json);
}

@freezed
class CreateDirectPaymentRequestDto with _$CreateDirectPaymentRequestDto {
  const factory CreateDirectPaymentRequestDto({
    required String senderAccount,
    required String receiverAccount,
    required String? referenceAccount,
    required int amount,
    required Cluster cluster,
    @Default(false) bool durable,
  }) = _CreateDirectPaymentRequestDto;

  factory CreateDirectPaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDirectPaymentRequestDtoFromJson(json);
}

@freezed
class CreateDirectPaymentResponseDto with _$CreateDirectPaymentResponseDto {
  const factory CreateDirectPaymentResponseDto({
    required int fee,
    required String transaction,
    required BigInt slot,
  }) = _CreateDirectPaymentResponseDto;

  factory CreateDirectPaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreateDirectPaymentResponseDtoFromJson(json);
}

@freezed
class CancelPaymentRequestDto with _$CancelPaymentRequestDto {
  const factory CancelPaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
    required Cluster cluster,
    @Default(false) bool durable,
  }) = _CancelPaymentRequestDto;

  factory CancelPaymentRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CancelPaymentRequestDtoFromJson(json);
}

@freezed
class CancelPaymentResponseDto with _$CancelPaymentResponseDto {
  const factory CancelPaymentResponseDto({
    required String transaction,
    required BigInt slot,
  }) = _CancelPaymentResponseDto;

  factory CancelPaymentResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CancelPaymentResponseDtoFromJson(json);
}

enum Cluster { mainnet, devnet }

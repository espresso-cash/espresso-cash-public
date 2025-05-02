import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments.freezed.dart';

@freezed
class CreateDirectPaymentRequestDto with _$CreateDirectPaymentRequestDto {
  const factory CreateDirectPaymentRequestDto({
    required String senderAccount,
    required String receiverAccount,
    required String? referenceAccount,
    required int amount,
    required String mintAddress,
  }) = _CreateDirectPaymentRequestDto;
}

@freezed
class CreateDirectPaymentResponseDto with _$CreateDirectPaymentResponseDto {
  const factory CreateDirectPaymentResponseDto({
    required int fee,
    required String transaction,
    required BigInt slot,
  }) = _CreateDirectPaymentResponseDto;
}

@freezed
class CreatePaymentRequestDto with _$CreatePaymentRequestDto {
  const factory CreatePaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
    required int amount,
  }) = _CreatePaymentRequestDto;
}

@freezed
class CreatePaymentResponseDto with _$CreatePaymentResponseDto {
  const factory CreatePaymentResponseDto({required String transaction, required BigInt slot}) =
      _CreatePaymentResponseDto;
}

@freezed
class ReceivePaymentRequestDto with _$ReceivePaymentRequestDto {
  const factory ReceivePaymentRequestDto({
    required String receiverAccount,
    required String escrowAccount,
  }) = _ReceivePaymentRequestDto;
}

@freezed
class ReceivePaymentResponseDto with _$ReceivePaymentResponseDto {
  const factory ReceivePaymentResponseDto({required String transaction, required BigInt slot}) =
      _ReceivePaymentResponseDto;
}

@freezed
class CancelPaymentRequestDto with _$CancelPaymentRequestDto {
  const factory CancelPaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
  }) = _CancelPaymentRequestDto;
}

@freezed
class CancelPaymentResponseDto with _$CancelPaymentResponseDto {
  const factory CancelPaymentResponseDto({required String transaction, required BigInt slot}) =
      _CancelPaymentResponseDto;
}

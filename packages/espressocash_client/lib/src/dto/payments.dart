import 'package:freezed_annotation/freezed_annotation.dart';

part 'payments.freezed.dart';

@freezed
sealed class CreateDirectPaymentRequestDto with _$CreateDirectPaymentRequestDto {
  const factory CreateDirectPaymentRequestDto({
    required String senderAccount,
    required String receiverAccount,
    required String? referenceAccount,
    required int amount,
    required String mintAddress,
  }) = _CreateDirectPaymentRequestDto;
}

@freezed
sealed class CreateDirectPaymentResponseDto with _$CreateDirectPaymentResponseDto {
  const factory CreateDirectPaymentResponseDto({
    required int fee,
    required String transaction,
    required BigInt slot,
  }) = _CreateDirectPaymentResponseDto;
}

@freezed
sealed class CreatePaymentRequestDto with _$CreatePaymentRequestDto {
  const factory CreatePaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
    required int amount,
  }) = _CreatePaymentRequestDto;
}

@freezed
sealed class CreatePaymentResponseDto with _$CreatePaymentResponseDto {
  const factory CreatePaymentResponseDto({required String transaction, required BigInt slot}) =
      _CreatePaymentResponseDto;
}

@freezed
sealed class ReceivePaymentRequestDto with _$ReceivePaymentRequestDto {
  const factory ReceivePaymentRequestDto({
    required String receiverAccount,
    required String escrowAccount,
  }) = _ReceivePaymentRequestDto;
}

@freezed
sealed class ReceivePaymentResponseDto with _$ReceivePaymentResponseDto {
  const factory ReceivePaymentResponseDto({required String transaction, required BigInt slot}) =
      _ReceivePaymentResponseDto;
}

@freezed
sealed class CancelPaymentRequestDto with _$CancelPaymentRequestDto {
  const factory CancelPaymentRequestDto({
    required String senderAccount,
    required String escrowAccount,
  }) = _CancelPaymentRequestDto;
}

@freezed
sealed class CancelPaymentResponseDto with _$CancelPaymentResponseDto {
  const factory CancelPaymentResponseDto({required String transaction, required BigInt slot}) =
      _CancelPaymentResponseDto;
}

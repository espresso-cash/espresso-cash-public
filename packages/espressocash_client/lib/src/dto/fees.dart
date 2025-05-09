import 'package:freezed_annotation/freezed_annotation.dart';

part 'fees.freezed.dart';

@freezed
class DirectPaymentQuoteRequestDto with _$DirectPaymentQuoteRequestDto {
  const factory DirectPaymentQuoteRequestDto({
    required String receiverAccount,
    required int amount,
    required String mintAddress,
  }) = _DirectPaymentQuoteRequestDto;
}

@freezed
class DirectPaymentQuoteResponseDto with _$DirectPaymentQuoteResponseDto {
  const factory DirectPaymentQuoteResponseDto({required int fee, required int totalAmount}) =
      _DirectPaymentQuoteResponseDto;
}

@freezed
class EscrowPaymentQuoteResponseDto with _$EscrowPaymentQuoteResponseDto {
  const factory EscrowPaymentQuoteResponseDto({required int fee}) = _EscrowPaymentQuoteResponseDto;
}

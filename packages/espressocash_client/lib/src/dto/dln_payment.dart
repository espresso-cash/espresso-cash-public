import 'package:freezed_annotation/freezed_annotation.dart';

part 'dln_payment.freezed.dart';

@freezed
abstract class OutgoingQuoteRequestDto with _$OutgoingQuoteRequestDto {
  const factory OutgoingQuoteRequestDto({
    required int amount,
    required String receiverAddress,
    required String receiverBlockchain,
  }) = _OutgoingQuoteRequestDto;
}

@freezed
abstract class OutgoingQuoteResponseDto with _$OutgoingQuoteResponseDto {
  const factory OutgoingQuoteResponseDto({
    required int inputAmount,
    required int receiverAmount,
    required String encodedTx,
    required int feeInUsdc,
    required BigInt slot,
  }) = _OutgoingQuoteResponseDto;
}

@freezed
abstract class OrderStatusDlnRequestDto with _$OrderStatusDlnRequestDto {
  const factory OrderStatusDlnRequestDto({required String orderId}) = _OrderStatusDlnRequestDto;
}

@freezed
abstract class OrderStatusDlnResponseDto with _$OrderStatusDlnResponseDto {
  const factory OrderStatusDlnResponseDto({required DlnOrderStatus status}) =
      _OrderStatusDlnResponseDto;
}

@freezed
abstract class OrderIdDlnRequestDto with _$OrderIdDlnRequestDto {
  const factory OrderIdDlnRequestDto({required String txId}) = _OrderIdDlnRequestDto;
}

@freezed
abstract class OrderIdDlnResponseDto with _$OrderIdDlnResponseDto {
  const factory OrderIdDlnResponseDto({required String? orderId}) = _OrderIdDlnResponseDto;
}

@freezed
abstract class IncomingQuoteRequestDto with _$IncomingQuoteRequestDto {
  const factory IncomingQuoteRequestDto({
    required int amount,
    required String senderAddress,
    required String senderBlockchain,
    required String receiverAddress,
    required String? solanaReferenceAddress,
  }) = _IncomingQuoteRequestDto;
}

@freezed
abstract class IncomingQuoteResponseDto with _$IncomingQuoteResponseDto {
  const factory IncomingQuoteResponseDto({
    required QuoteTx tx,
    required QuoteUsdcInfo usdcInfo,
    required int inputAmount,
    required int receiverAmount,
    required int feeInUsdc,
  }) = _IncomingQuoteResponseDto;
}

@freezed
abstract class QuoteTx with _$QuoteTx {
  const factory QuoteTx({required String to, required String data, required int value}) = _QuoteTx;
}

@freezed
abstract class QuoteUsdcInfo with _$QuoteUsdcInfo {
  const factory QuoteUsdcInfo({required String usdcAddress, required int approvalAmount}) =
      _QuoteUsdcInfo;
}

enum DlnOrderStatus {
  none,
  created,
  fulfilled,
  sentUnlock,
  orderCancelled,
  sentOrderCancel,
  claimedUnlock,
  claimedOrderCancel,
}

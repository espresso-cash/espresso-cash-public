import 'package:freezed_annotation/freezed_annotation.dart';

part 'dln_payment.freezed.dart';
part 'dln_payment.g.dart';

@freezed
class PaymentQuoteRequestDto with _$PaymentQuoteRequestDto {
  const factory PaymentQuoteRequestDto({
    required int amount,
    required String receiverAddress,
    required String receiverBlockchain,
  }) = _PaymentQuoteRequestDto;

  factory PaymentQuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentQuoteRequestDtoFromJson(json);
}

@freezed
class PaymentQuoteResponseDto with _$PaymentQuoteResponseDto {
  const factory PaymentQuoteResponseDto({
    required int inputAmount,
    required int receiverAmount,
    required String encodedTx,
    required int feeInUsdc,
    required BigInt slot,
  }) = _PaymentQuoteResponseDto;

  factory PaymentQuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PaymentQuoteResponseDtoFromJson(json);
}

@freezed
class OrderStatusDlnRequestDto with _$OrderStatusDlnRequestDto {
  const factory OrderStatusDlnRequestDto({
    required String orderId,
  }) = _OrderStatusDlnRequestDto;

  factory OrderStatusDlnRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusDlnRequestDtoFromJson(json);
}

@freezed
class OrderStatusDlnResponseDto with _$OrderStatusDlnResponseDto {
  const factory OrderStatusDlnResponseDto({
    required DlnOrderStatus status,
  }) = _OrderStatusDlnResponseDto;

  factory OrderStatusDlnResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusDlnResponseDtoFromJson(json);
}

@freezed
class OrderIdDlnRequestDto with _$OrderIdDlnRequestDto {
  const factory OrderIdDlnRequestDto({
    required String txId,
  }) = _OrderIdDlnRequestDto;

  factory OrderIdDlnRequestDto.fromJson(Map<String, dynamic> json) =>
      _$OrderIdDlnRequestDtoFromJson(json);
}

@freezed
class OrderIdDlnResponseDto with _$OrderIdDlnResponseDto {
  const factory OrderIdDlnResponseDto({
    required String? orderId,
  }) = _OrderIdDlnResponseDto;

  factory OrderIdDlnResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderIdDlnResponseDtoFromJson(json);
}

@freezed
class IncomingQuoteRequestDto with _$IncomingQuoteRequestDto {
  const factory IncomingQuoteRequestDto({
    required int amount,
    required String senderAddress,
    required String senderBlockchain,
    required String receiverAddress,
    required String? solanaReferenceAddress,
  }) = _IncomingQuoteRequestDto;

  factory IncomingQuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$IncomingQuoteRequestDtoFromJson(json);
}

@freezed
class IncomingQuoteResponseDto with _$IncomingQuoteResponseDto {
  const factory IncomingQuoteResponseDto({
    required QuoteTx tx,
    required QuoteUsdcInfo usdcInfo,
    required int inputAmount,
    required int receiverAmount,
    required int feeInUsdc,
  }) = _IncomingQuoteResponseDto;

  factory IncomingQuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$IncomingQuoteResponseDtoFromJson(json);
}

@freezed
class QuoteTx with _$QuoteTx {
  const factory QuoteTx({
    required String to,
    required String data,
    required int value,
  }) = _QuoteTx;

  factory QuoteTx.fromJson(Map<String, dynamic> json) =>
      _$QuoteTxFromJson(json);
}

@freezed
class QuoteUsdcInfo with _$QuoteUsdcInfo {
  const factory QuoteUsdcInfo({
    required String usdcAddress,
    required int approvalAmount,
  }) = _QuoteUsdcInfo;

  factory QuoteUsdcInfo.fromJson(Map<String, dynamic> json) =>
      _$QuoteUsdcInfoFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum DlnOrderStatus {
  none,
  created,
  fulfilled,
  sentUnlock,
  orderCancelled,
  sentOrderCancel,
  claimedUnlock,
  claimedOrderCancel
}

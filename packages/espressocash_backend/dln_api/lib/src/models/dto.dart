// ignore_for_file: invalid_annotation_target

import 'package:dln_api/src/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
class DlnQuoteRequestDto with _$DlnQuoteRequestDto {
  const factory DlnQuoteRequestDto({
    required String srcChainId,
    required String srcChainTokenIn,
    required String srcChainTokenInAmount,
    required String dstChainId,
    required String dstChainTokenOut,
    String? dstChainTokenOutAmount,
    int? additionalTakerRewardBps,
    String? srcIntermediaryTokenAddress,
    String? dstIntermediaryTokenAddress,
    String? dstIntermediaryTokenSpenderAddress,
    int? intermediaryTokenUSDPrice,
    int? slippage,
    double? affiliateFeePercent,
    bool? prependOperatingExpenses,
  }) = _DlnQuoteRequestDto;

  factory DlnQuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$DlnQuoteRequestDtoFromJson(json);
}

@freezed
class DlnQuoteResponseDto with _$DlnQuoteResponseDto {
  const factory DlnQuoteResponseDto({
    required OrderEstimation estimation,
    String? prependedOperatingExpenseCost,
    required TxQuote tx,
    required Order order,
    required String fixFee,
  }) = _DlnQuoteResponseDto;

  factory DlnQuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DlnQuoteResponseDtoFromJson(json);
}

@freezed
class CreateTxRequestDto with _$CreateTxRequestDto {
  const factory CreateTxRequestDto({
    required String srcChainId,
    required String srcChainTokenIn,
    required String srcChainTokenInAmount,
    required String dstChainId,
    required String dstChainTokenOut,
    required String dstChainTokenOutRecipient,
    required String srcChainOrderAuthorityAddress,
    required String dstChainOrderAuthorityAddress,
    String? dstChainTokenOutAmount,
    double? additionalTakerRewardBps,
    String? srcIntermediaryTokenAddress,
    String? dstIntermediaryTokenAddress,
    String? dstIntermediaryTokenSpenderAddress,
    double? intermediaryTokenUSDPrice,
    double? slippage,
    String? senderAddress,
    double? referralCode,
    double? affiliateFeePercent,
    String? affiliateFeeRecipient,
    String? srcChainTokenInSenderPermit,
    bool? enableEstimate,
    String? allowedTaker,
    String? externalCall,
    bool? prependOperatingExpenses,
  }) = _CreateTxRequestDto;

  factory CreateTxRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTxRequestDtoFromJson(json);
}

@freezed
class CreateTxResponseDto with _$CreateTxResponseDto {
  const factory CreateTxResponseDto({
    required OrderEstimation estimation,
    required DlnTx tx,
    String? prependedOperatingExpenseCost,
    required Order order,
    required String fixFee,
  }) = _CreateTxResponseDto;

  factory CreateTxResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CreateTxResponseDtoFromJson(json);
}

@freezed
class OrderResponseDto with _$OrderResponseDto {
  const factory OrderResponseDto({
    required String orderId,
    required String status,
    required String externalCallState,
    required OrderStruct orderStruct,
  }) = _OrderResponseDto;

  factory OrderResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseDtoFromJson(json);
}

@freezed
class OrderStatusResponseDto with _$OrderStatusResponseDto {
  const factory OrderStatusResponseDto({
    required String orderId,
    @JsonKey(unknownEnumValue: OrderStatus.unknown) required OrderStatus status,
  }) = _OrderStatusResponseDto;

  factory OrderStatusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusResponseDtoFromJson(json);
}

@freezed
class OrderIdTxResponseDto with _$OrderIdTxResponseDto {
  const factory OrderIdTxResponseDto({
    required List<String> orderIds,
  }) = _OrderIdTxResponseDto;

  factory OrderIdTxResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderIdTxResponseDtoFromJson(json);
}

@freezed
class CancelTxResponseDto with _$CancelTxResponseDto {
  const factory CancelTxResponseDto({
    required String to,
    required String data,
    required String value,
    required double chainId,
    required String from,
    String? cancelBeneficiary,
  }) = _CancelTxResponseDto;

  factory CancelTxResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CancelTxResponseDtoFromJson(json);
}

@JsonEnum(fieldRename: FieldRename.pascal)
enum OrderStatus {
  created,
  fulfilled,
  sentUnlock,
  claimedUnlock,
  orderCancelled,
  sentOrderCancel,
  claimedOrderCancel,
  unknown
}

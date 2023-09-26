import 'package:dln_api/src/models/models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dto.freezed.dart';
part 'dto.g.dart';

@freezed
class QuoteRequestDto with _$QuoteRequestDto {
  const factory QuoteRequestDto({
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
  }) = _QuoteRequestDto;

  factory QuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestDtoFromJson(json);
}

@freezed
class QuoteResponseDto with _$QuoteResponseDto {
  const factory QuoteResponseDto({
    required OrderEstimation estimation,
    String? prependedOperatingExpenseCost,
    required TxQuote tx,
    required Order order,
    required String fixFee,
  }) = _QuoteResponseDto;

  factory QuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseDtoFromJson(json);
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
    required String status,
  }) = _OrderStatusResponseDto;

  factory OrderStatusResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusResponseDtoFromJson(json);
}

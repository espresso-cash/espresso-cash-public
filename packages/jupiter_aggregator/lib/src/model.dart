// ignore_for_file: invalid_annotation_target, freezed compatibility

import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.freezed.dart';
part 'model.g.dart';

enum SwapMode {
  @JsonValue('ExactIn')
  exactIn,
  @JsonValue('ExactOut')
  exactOut,
}

@freezed
class JupiterMarketFee with _$JupiterMarketFee {
  const factory JupiterMarketFee({String? amount, num? feeBps}) = _JupiterMarketFee;

  factory JupiterMarketFee.fromJson(Map<String, dynamic> json) => _$JupiterMarketFeeFromJson(json);
}

@freezed
class RoutePlan with _$RoutePlan {
  const factory RoutePlan({required JupiterSwapInfo swapInfo, required int percent}) = _RoutePlan;

  factory RoutePlan.fromJson(Map<String, dynamic> json) => _$RoutePlanFromJson(json);
}

@freezed
class JupiterSwapInfo with _$JupiterSwapInfo {
  const factory JupiterSwapInfo({
    required String ammKey,
    String? label,
    required String inputMint,
    required String outputMint,
    required String inAmount,
    required String outAmount,
    required String feeAmount,
    required String feeMint,
  }) = _JupiterSwapInfo;

  factory JupiterSwapInfo.fromJson(Map<String, dynamic> json) => _$JupiterSwapInfoFromJson(json);
}

@freezed
class QuoteResponseDto with _$QuoteResponseDto {
  const factory QuoteResponseDto({
    required String inputMint,
    required String inAmount,
    required String outputMint,
    required String outAmount,
    required String otherAmountThreshold,
    @Default(SwapMode.exactIn) SwapMode swapMode,
    required int slippageBps,
    JupiterMarketFee? platformFee,
    required String priceImpactPct,
    required List<RoutePlan> routePlan,
    num? contextSlot,
    double? timeTaken,
  }) = _QuoteResponseDto;

  factory QuoteResponseDto.fromJson(Map<String, dynamic> json) => _$QuoteResponseDtoFromJson(json);
}

@freezed
class QuoteRequestDto with _$QuoteRequestDto {
  const factory QuoteRequestDto({
    required String inputMint,
    required String outputMint,
    required int amount,
    int? slippageBps,
    @Default(SwapMode.exactIn) SwapMode swapMode,
    List<String>? dexes,
    List<String>? excludeDexes,
    bool? onlyDirectRoutes,
    bool? asLegacyTransaction,
    int? platformFeeBps,
    int? maxAccounts,
    bool? restrictIntermediateTokens,
    bool? autoSlippage,
    int? maxAutoSlippageBps,
    int? autoSlippageCollisionUsdValue,
  }) = _QuoteRequestDto;

  factory QuoteRequestDto.fromJson(Map<String, dynamic> json) => _$QuoteRequestDtoFromJson(json);
}

@freezed
class JupiterSwapRequestDto with _$JupiterSwapRequestDto {
  const factory JupiterSwapRequestDto({
    required String userPublicKey,
    required QuoteResponseDto quoteResponse,
    @Default(true) bool? wrapAndUnwrapSol,
    @Default(true) bool? useSharedAccounts,
    String? feeAccount,
    int? computeUnitPriceMicroLamports,
    int? prioritizationFeeLamports,
    bool? asLegacyTransaction,
    bool? restrictIntermediateTokens,
    bool? useTokenLedger,
    String? destinationTokenAccount,
    bool? dynamicComputeUnitLimit,
    bool? skipUserAccountsRpcCalls,
    String? trackingAccount,
    DynamicSlippage? dynamicSlippage,
  }) = _JupiterSwapRequestDto;

  factory JupiterSwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$JupiterSwapRequestDtoFromJson(json);
}

@freezed
class DynamicSlippage with _$DynamicSlippage {
  const factory DynamicSlippage({required int minBps, required int maxBps}) = _DynamicSlippage;

  factory DynamicSlippage.fromJson(Map<String, dynamic> json) => _$DynamicSlippageFromJson(json);
}

@freezed
class JupiterSwapResponseDto with _$JupiterSwapResponseDto {
  const factory JupiterSwapResponseDto({
    required String swapTransaction,
    required int lastValidBlockHeight,
    int? prioritizationFeeLamports,
    DynamicSlippageReport? dynamicSlippageReport,
  }) = _JupiterSwapResponseDto;

  factory JupiterSwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$JupiterSwapResponseDtoFromJson(json);
}

@freezed
class DynamicSlippageReport with _$DynamicSlippageReport {
  const factory DynamicSlippageReport({
    int? slippageBps,
    int? otherAmount,
    int? simulatedIncurredSlippageBps,
    String? amplificationRatio,
  }) = _DynamicSlippageReport;

  factory DynamicSlippageReport.fromJson(Map<String, dynamic> json) =>
      _$DynamicSlippageReportFromJson(json);
}

@freezed
class PriceRequestDto with _$PriceRequestDto {
  const factory PriceRequestDto({@JsonKey(toJson: _listToString) required List<String> ids}) =
      _PriceRequestDto;

  factory PriceRequestDto.fromJson(Map<String, dynamic> json) => _$PriceRequestDtoFromJson(json);
}

@freezed
class PriceResponseDto with _$PriceResponseDto {
  const factory PriceResponseDto({required Map<String, PriceDto> data}) = _PriceResponseDto;

  factory PriceResponseDto.fromJson(Map<String, dynamic> json) => _$PriceResponseDtoFromJson(json);
}

@freezed
class PriceDto with _$PriceDto {
  const factory PriceDto({required String? price}) = _PriceDto;

  factory PriceDto.fromJson(Map<String, dynamic> json) => _$PriceDtoFromJson(json);
}

String _listToString(List<String> list) => list.join(',');

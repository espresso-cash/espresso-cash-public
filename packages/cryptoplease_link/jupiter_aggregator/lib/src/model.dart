// ignore_for_file: invalid_annotation_target

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
class JupiterIndexedRouteMap with _$JupiterIndexedRouteMap {
  const factory JupiterIndexedRouteMap({
    required List<String> mintKeys,
    required Map<String, List<int>> indexedRouteMap,
  }) = _JupiterIndexedRouteMap;

  factory JupiterIndexedRouteMap.fromJson(Map<String, dynamic> json) =>
      _$JupiterIndexedRouteMapFromJson(json);
}

@freezed
class JupiterRoute with _$JupiterRoute {
  const factory JupiterRoute({
    required String inAmount,
    required String outAmount,
    required String amount,
    required String otherAmountThreshold,
    required int slippageBps,
    required num priceImpactPct,
    required List<JupiterMarket> marketInfos,
    required SwapMode swapMode,
    required JupiterRouteFee? fees,
  }) = _JupiterRoute;

  factory JupiterRoute.fromJson(Map<String, dynamic> json) =>
      _$JupiterRouteFromJson(json);
}

extension JupiterRouteExt on JupiterRoute {
  bool isSameRouteAs(JupiterRoute other) {
    if (marketInfos.length != other.marketInfos.length) return false;
    for (var i = 0; i < marketInfos.length; i++) {
      if (marketInfos[i].id != other.marketInfos[i].id) return false;
    }

    return true;
  }
}

@freezed
class JupiterMarket with _$JupiterMarket {
  const factory JupiterMarket({
    required String id,
    required String label,
    required String inputMint,
    required String outputMint,
    required bool notEnoughLiquidity,
    required String inAmount,
    required String outAmount,
    required num priceImpactPct,
    required String? minInAmount,
    required String? minOutAmount,
    required JupiterMarketFee lpFee,
    required JupiterMarketFee platformFee,
  }) = _JupiterMarket;

  factory JupiterMarket.fromJson(Map<String, dynamic> json) =>
      _$JupiterMarketFromJson(json);
}

@freezed
class JupiterMarketFee with _$JupiterMarketFee {
  const factory JupiterMarketFee({
    required String amount,
    required String mint,
    required num pct,
  }) = _JupiterMarketFee;

  factory JupiterMarketFee.fromJson(Map<String, dynamic> json) =>
      _$JupiterMarketFeeFromJson(json);
}

@freezed
class JupiterRouteFee with _$JupiterRouteFee {
  const factory JupiterRouteFee({
    required num signatureFee,
    required List<num> openOrdersDeposits,
    required List<num> ataDeposits,
    required num totalFeeAndDeposits,
    required num minimumSOLForTransaction,
  }) = _JupiterRouteFee;

  factory JupiterRouteFee.fromJson(Map<String, dynamic> json) =>
      _$JupiterRouteFeeFromJson(json);
}

@freezed
class QuoteResponseDto with _$QuoteResponseDto {
  const factory QuoteResponseDto({
    @JsonKey(name: 'data') required List<JupiterRoute> routes,
  }) = _QuoteResponseDto;

  factory QuoteResponseDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteResponseDtoFromJson(json);
}

@freezed
class IndexedRouteMapRequestDto with _$IndexedRouteMapRequestDto {
  const factory IndexedRouteMapRequestDto({
    bool? onlyDirectRoutes,
  }) = _IndexedRouteMapRequestDto;

  factory IndexedRouteMapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$IndexedRouteMapRequestDtoFromJson(json);
}

@freezed
class QuoteRequestDto with _$QuoteRequestDto {
  const factory QuoteRequestDto({
    required String inputMint,
    required String outputMint,
    required String amount,
    @Default(SwapMode.exactIn) SwapMode swapMode,
    int? slippageBps,
    int? feeBps,
    bool? onlyDirectRoutes,
    String? userPublicKey,
    bool? enforceSingleTx,
  }) = _QuoteRequestDto;

  factory QuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestDtoFromJson(json);
}

@freezed
class JupiterSwapRequestDto with _$JupiterSwapRequestDto {
  const factory JupiterSwapRequestDto({
    required String userPublicKey,
    required JupiterRoute route,
    bool? wrapUnwrapSOL,
    String? feeAccount,
    String? destinationWallet,
  }) = _JupiterSwapRequestDto;

  factory JupiterSwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$JupiterSwapRequestDtoFromJson(json);
}

@freezed
class JupiterSwapResponseDto with _$JupiterSwapResponseDto {
  const factory JupiterSwapResponseDto({
    required String? setupTransaction,
    required String swapTransaction,
    required String? cleanupTransaction,
  }) = _JupiterSwapResponseDto;

  factory JupiterSwapResponseDto.fromJson(Map<String, dynamic> json) =>
      _$JupiterSwapResponseDtoFromJson(json);
}

@freezed
class PriceRequestDto with _$PriceRequestDto {
  const factory PriceRequestDto({
    required String id,
  }) = _PriceRequestDto;

  factory PriceRequestDto.fromJson(Map<String, dynamic> json) =>
      _$PriceRequestDtoFromJson(json);
}

@freezed
class PriceResponseDto with _$PriceResponseDto {
  const factory PriceResponseDto({
    @JsonKey(name: 'data', readValue: _readPrice) required double price,
  }) = _PriceResponseDto;

  factory PriceResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PriceResponseDtoFromJson(json);
}

dynamic _readPrice(Map<dynamic, dynamic> map, String key) =>
    (map[key] as Map)['price'] as double;

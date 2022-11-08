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
class JupiterSwapTransactions with _$JupiterSwapTransactions {
  const factory JupiterSwapTransactions({
    required String? setupTransaction,
    required String swapTransaction,
    required String? cleanupTransaction,
  }) = _JupiterSwapTransactions;

  factory JupiterSwapTransactions.fromJson(Map<String, dynamic> json) =>
      _$JupiterSwapTransactionsFromJson(json);
}

@freezed
class JupiterRoute with _$JupiterRoute {
  @JsonSerializable(explicitToJson: true)
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
  @JsonSerializable(explicitToJson: true)
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
  @JsonSerializable(explicitToJson: true)
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
  @JsonSerializable(explicitToJson: true)
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
    @JsonKey(includeIfNull: false) bool? onlyDirectRoutes,
  }) = _IndexedRouteMapRequestDto;

  factory IndexedRouteMapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$IndexedRouteMapRequestDtoFromJson(json);
}

@freezed
class QuoteRequestDto with _$QuoteRequestDto {
  @JsonSerializable(explicitToJson: true)
  const factory QuoteRequestDto({
    required String inputMint,
    required String outputMint,
    required String amount,
    @Default(SwapMode.exactIn) SwapMode swapMode,
    @JsonKey(includeIfNull: false) int? slippageBps,
    @JsonKey(includeIfNull: false) int? feeBps,
    @JsonKey(includeIfNull: false) bool? onlyDirectRoutes,
    @JsonKey(includeIfNull: false) String? userPublicKey,
    @JsonKey(includeIfNull: false) bool? enforceSingleTx,
  }) = _QuoteRequestDto;

  factory QuoteRequestDto.fromJson(Map<String, dynamic> json) =>
      _$QuoteRequestDtoFromJson(json);
}

@freezed
class SwapRequestDto with _$SwapRequestDto {
  @JsonSerializable(explicitToJson: true)
  const factory SwapRequestDto({
    required String userPublicKey,
    required JupiterRoute route,
    @JsonKey(includeIfNull: false) bool? wrapUnwrapSOL,
    @JsonKey(includeIfNull: false) String? feeAccount,
    @JsonKey(includeIfNull: false) String? destinationWallet,
  }) = _SwapRequestDto;

  factory SwapRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SwapRequestDtoFromJson(json);
}

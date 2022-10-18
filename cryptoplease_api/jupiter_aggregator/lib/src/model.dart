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
  const factory JupiterRoute({
    required int inAmount,
    required int outAmount,
    required int otherAmountThreshold,
    required double? priceImpactPct,
    required List<JupiterMarket> marketInfos,
    required SwapMode swapMode,
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
    required int inAmount,
    required int outAmount,
    required double? priceImpactPct,
    required JupiterFee lpFee,
    required JupiterFee platformFee,
  }) = _JupiterMarket;

  factory JupiterMarket.fromJson(Map<String, dynamic> json) =>
      _$JupiterMarketFromJson(json);
}

@freezed
class JupiterFee with _$JupiterFee {
  const factory JupiterFee({
    required double amount,
    required String mint,
    required double? pct,
  }) = _JupiterFee;

  factory JupiterFee.fromJson(Map<String, dynamic> json) =>
      _$JupiterFeeFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JupiterIndexedRouteMap _$$_JupiterIndexedRouteMapFromJson(
        Map<String, dynamic> json) =>
    _$_JupiterIndexedRouteMap(
      mintKeys:
          (json['mintKeys'] as List<dynamic>).map((e) => e as String).toList(),
      indexedRouteMap: (json['indexedRouteMap'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as int).toList()),
      ),
    );

Map<String, dynamic> _$$_JupiterIndexedRouteMapToJson(
        _$_JupiterIndexedRouteMap instance) =>
    <String, dynamic>{
      'mintKeys': instance.mintKeys,
      'indexedRouteMap': instance.indexedRouteMap,
    };

_$_JupiterSwapTransactions _$$_JupiterSwapTransactionsFromJson(
        Map<String, dynamic> json) =>
    _$_JupiterSwapTransactions(
      setupTransaction: json['setupTransaction'] as String?,
      swapTransaction: json['swapTransaction'] as String,
      cleanupTransaction: json['cleanupTransaction'] as String?,
    );

Map<String, dynamic> _$$_JupiterSwapTransactionsToJson(
        _$_JupiterSwapTransactions instance) =>
    <String, dynamic>{
      'setupTransaction': instance.setupTransaction,
      'swapTransaction': instance.swapTransaction,
      'cleanupTransaction': instance.cleanupTransaction,
    };

_$_JupiterRoute _$$_JupiterRouteFromJson(Map<String, dynamic> json) =>
    _$_JupiterRoute(
      inAmount: json['inAmount'] as int,
      outAmount: json['outAmount'] as int,
      otherAmountThreshold: json['otherAmountThreshold'] as int,
      priceImpactPct: (json['priceImpactPct'] as num?)?.toDouble(),
      marketInfos: (json['marketInfos'] as List<dynamic>)
          .map((e) => JupiterMarket.fromJson(e as Map<String, dynamic>))
          .toList(),
      swapMode: $enumDecode(_$SwapModeEnumMap, json['swapMode']),
    );

Map<String, dynamic> _$$_JupiterRouteToJson(_$_JupiterRoute instance) =>
    <String, dynamic>{
      'inAmount': instance.inAmount,
      'outAmount': instance.outAmount,
      'otherAmountThreshold': instance.otherAmountThreshold,
      'priceImpactPct': instance.priceImpactPct,
      'marketInfos': instance.marketInfos,
      'swapMode': _$SwapModeEnumMap[instance.swapMode]!,
    };

const _$SwapModeEnumMap = {
  SwapMode.exactIn: 'ExactIn',
  SwapMode.exactOut: 'ExactOut',
};

_$_JupiterMarket _$$_JupiterMarketFromJson(Map<String, dynamic> json) =>
    _$_JupiterMarket(
      id: json['id'] as String,
      label: json['label'] as String,
      inputMint: json['inputMint'] as String,
      outputMint: json['outputMint'] as String,
      notEnoughLiquidity: json['notEnoughLiquidity'] as bool,
      inAmount: json['inAmount'] as int,
      outAmount: json['outAmount'] as int,
      priceImpactPct: (json['priceImpactPct'] as num?)?.toDouble(),
      lpFee: JupiterFee.fromJson(json['lpFee'] as Map<String, dynamic>),
      platformFee:
          JupiterFee.fromJson(json['platformFee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_JupiterMarketToJson(_$_JupiterMarket instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'inputMint': instance.inputMint,
      'outputMint': instance.outputMint,
      'notEnoughLiquidity': instance.notEnoughLiquidity,
      'inAmount': instance.inAmount,
      'outAmount': instance.outAmount,
      'priceImpactPct': instance.priceImpactPct,
      'lpFee': instance.lpFee,
      'platformFee': instance.platformFee,
    };

_$_JupiterFee _$$_JupiterFeeFromJson(Map<String, dynamic> json) =>
    _$_JupiterFee(
      amount: (json['amount'] as num).toDouble(),
      mint: json['mint'] as String,
      pct: (json['pct'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_JupiterFeeToJson(_$_JupiterFee instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'mint': instance.mint,
      'pct': instance.pct,
    };

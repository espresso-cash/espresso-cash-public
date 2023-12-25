// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JupiterIndexedRouteMapImpl _$$JupiterIndexedRouteMapImplFromJson(
        Map<String, dynamic> json) =>
    _$JupiterIndexedRouteMapImpl(
      mintKeys:
          (json['mintKeys'] as List<dynamic>).map((e) => e as String).toList(),
      indexedRouteMap: (json['indexedRouteMap'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as int).toList()),
      ),
    );

Map<String, dynamic> _$$JupiterIndexedRouteMapImplToJson(
        _$JupiterIndexedRouteMapImpl instance) =>
    <String, dynamic>{
      'mintKeys': instance.mintKeys,
      'indexedRouteMap': instance.indexedRouteMap,
    };

_$JupiterRouteImpl _$$JupiterRouteImplFromJson(Map<String, dynamic> json) =>
    _$JupiterRouteImpl(
      inAmount: json['inAmount'] as String,
      outAmount: json['outAmount'] as String,
      amount: json['amount'] as String,
      otherAmountThreshold: json['otherAmountThreshold'] as String,
      slippageBps: json['slippageBps'] as int,
      priceImpactPct: json['priceImpactPct'] as num,
      marketInfos: (json['marketInfos'] as List<dynamic>)
          .map((e) => JupiterMarket.fromJson(e as Map<String, dynamic>))
          .toList(),
      swapMode: $enumDecode(_$SwapModeEnumMap, json['swapMode']),
      fees: json['fees'] == null
          ? null
          : JupiterRouteFee.fromJson(json['fees'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JupiterRouteImplToJson(_$JupiterRouteImpl instance) {
  final val = <String, dynamic>{
    'ammKey': instance.ammKey,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('label', instance.label);
  val['inputMint'] = instance.inputMint;
  val['outputMint'] = instance.outputMint;
  val['inAmount'] = instance.inAmount;
  val['outAmount'] = instance.outAmount;
  val['feeAmount'] = instance.feeAmount;
  val['feeMint'] = instance.feeMint;
  return val;
}

_$QuoteResponseDtoImpl _$$QuoteResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$QuoteResponseDtoImpl(
      inputMint: json['inputMint'] as String,
      inAmount: json['inAmount'] as String,
      outputMint: json['outputMint'] as String,
      outAmount: json['outAmount'] as String,
      otherAmountThreshold: json['otherAmountThreshold'] as String,
      swapMode: $enumDecodeNullable(_$SwapModeEnumMap, json['swapMode']) ??
          SwapMode.exactIn,
      slippageBps: json['slippageBps'] as int,
      platformFee: json['platformFee'] == null
          ? null
          : JupiterMarketFee.fromJson(
              json['platformFee'] as Map<String, dynamic>),
      priceImpactPct: json['priceImpactPct'] as String,
      routePlan: (json['routePlan'] as List<dynamic>)
          .map((e) => RoutePlan.fromJson(e as Map<String, dynamic>))
          .toList(),
      contextSlot: json['contextSlot'] as num?,
      timeTaken: (json['timeTaken'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$QuoteResponseDtoImplToJson(
    _$QuoteResponseDtoImpl instance) {
  final val = <String, dynamic>{
    'inputMint': instance.inputMint,
    'inAmount': instance.inAmount,
    'outputMint': instance.outputMint,
    'outAmount': instance.outAmount,
    'otherAmountThreshold': instance.otherAmountThreshold,
    'swapMode': _$SwapModeEnumMap[instance.swapMode]!,
    'slippageBps': instance.slippageBps,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('platformFee', instance.platformFee?.toJson());
  val['priceImpactPct'] = instance.priceImpactPct;
  val['routePlan'] = instance.routePlan.map((e) => e.toJson()).toList();
  writeNotNull('contextSlot', instance.contextSlot);
  writeNotNull('timeTaken', instance.timeTaken);
  return val;
}

const _$SwapModeEnumMap = {
  SwapMode.exactIn: 'ExactIn',
  SwapMode.exactOut: 'ExactOut',
};

_$JupiterMarketImpl _$$JupiterMarketImplFromJson(Map<String, dynamic> json) =>
    _$JupiterMarketImpl(
      id: json['id'] as String,
      label: json['label'] as String,
      inputMint: json['inputMint'] as String,
      outputMint: json['outputMint'] as String,
      notEnoughLiquidity: json['notEnoughLiquidity'] as bool,
      inAmount: json['inAmount'] as String,
      outAmount: json['outAmount'] as String,
      priceImpactPct: json['priceImpactPct'] as num,
      minInAmount: json['minInAmount'] as String?,
      minOutAmount: json['minOutAmount'] as String?,
      lpFee: JupiterMarketFee.fromJson(json['lpFee'] as Map<String, dynamic>),
      platformFee: JupiterMarketFee.fromJson(
          json['platformFee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$JupiterMarketImplToJson(_$JupiterMarketImpl instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'label': instance.label,
    'inputMint': instance.inputMint,
    'outputMint': instance.outputMint,
    'notEnoughLiquidity': instance.notEnoughLiquidity,
    'inAmount': instance.inAmount,
    'outAmount': instance.outAmount,
    'priceImpactPct': instance.priceImpactPct,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('minInAmount', instance.minInAmount);
  writeNotNull('minOutAmount', instance.minOutAmount);
  val['lpFee'] = instance.lpFee.toJson();
  val['platformFee'] = instance.platformFee.toJson();
  return val;
}

_$JupiterMarketFeeImpl _$$JupiterMarketFeeImplFromJson(
        Map<String, dynamic> json) =>
    _$JupiterMarketFeeImpl(
      amount: json['amount'] as String,
      mint: json['mint'] as String,
      pct: json['pct'] as num,
    );

Map<String, dynamic> _$$JupiterMarketFeeImplToJson(
        _$JupiterMarketFeeImpl instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'mint': instance.mint,
      'pct': instance.pct,
    };

_$JupiterRouteFeeImpl _$$JupiterRouteFeeImplFromJson(
        Map<String, dynamic> json) =>
    _$JupiterRouteFeeImpl(
      signatureFee: json['signatureFee'] as num,
      openOrdersDeposits: (json['openOrdersDeposits'] as List<dynamic>)
          .map((e) => e as num)
          .toList(),
      ataDeposits:
          (json['ataDeposits'] as List<dynamic>).map((e) => e as num).toList(),
      totalFeeAndDeposits: json['totalFeeAndDeposits'] as num,
      minimumSOLForTransaction: json['minimumSOLForTransaction'] as num,
    );

Map<String, dynamic> _$$JupiterRouteFeeImplToJson(
        _$JupiterRouteFeeImpl instance) =>
    <String, dynamic>{
      'signatureFee': instance.signatureFee,
      'openOrdersDeposits': instance.openOrdersDeposits,
      'ataDeposits': instance.ataDeposits,
      'totalFeeAndDeposits': instance.totalFeeAndDeposits,
      'minimumSOLForTransaction': instance.minimumSOLForTransaction,
    };

_$QuoteResponseDtoImpl _$$QuoteResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$QuoteResponseDtoImpl(
      routes: (json['data'] as List<dynamic>)
          .map((e) => JupiterRoute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$QuoteResponseDtoImplToJson(
        _$QuoteResponseDtoImpl instance) =>
    <String, dynamic>{
      'data': instance.routes.map((e) => e.toJson()).toList(),
    };

_$IndexedRouteMapRequestDtoImpl _$$IndexedRouteMapRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$IndexedRouteMapRequestDtoImpl(
      onlyDirectRoutes: json['onlyDirectRoutes'] as bool?,
    );

Map<String, dynamic> _$$IndexedRouteMapRequestDtoImplToJson(
    _$IndexedRouteMapRequestDtoImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('onlyDirectRoutes', instance.onlyDirectRoutes);
  return val;
}

_$QuoteRequestDtoImpl _$$QuoteRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$QuoteRequestDtoImpl(
      inputMint: json['inputMint'] as String,
      outputMint: json['outputMint'] as String,
      amount: json['amount'] as int,
      slippageBps: json['slippageBps'] as int?,
      swapMode: $enumDecodeNullable(_$SwapModeEnumMap, json['swapMode']) ??
          SwapMode.exactIn,
      dexes:
          (json['dexes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      excludeDexes: (json['excludeDexes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      onlyDirectRoutes: json['onlyDirectRoutes'] as bool?,
      asLegacyTransaction: json['asLegacyTransaction'] as bool?,
      platformFeeBps: json['platformFeeBps'] as int?,
      maxAccounts: json['maxAccounts'] as int?,
    );

Map<String, dynamic> _$$QuoteRequestDtoImplToJson(
    _$QuoteRequestDtoImpl instance) {
  final val = <String, dynamic>{
    'inputMint': instance.inputMint,
    'outputMint': instance.outputMint,
    'amount': instance.amount,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('slippageBps', instance.slippageBps);
  val['swapMode'] = _$SwapModeEnumMap[instance.swapMode]!;
  writeNotNull('dexes', instance.dexes);
  writeNotNull('excludeDexes', instance.excludeDexes);
  writeNotNull('onlyDirectRoutes', instance.onlyDirectRoutes);
  writeNotNull('asLegacyTransaction', instance.asLegacyTransaction);
  writeNotNull('platformFeeBps', instance.platformFeeBps);
  writeNotNull('maxAccounts', instance.maxAccounts);
  return val;
}

_$JupiterSwapRequestDtoImpl _$$JupiterSwapRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$JupiterSwapRequestDtoImpl(
      userPublicKey: json['userPublicKey'] as String,
      quoteResponse: QuoteResponseDto.fromJson(
          json['quoteResponse'] as Map<String, dynamic>),
      wrapAndUnwrapSol: json['wrapAndUnwrapSol'] as bool? ?? true,
      useSharedAccounts: json['useSharedAccounts'] as bool? ?? true,
      feeAccount: json['feeAccount'] as String?,
      computeUnitPriceMicroLamports:
          json['computeUnitPriceMicroLamports'] as int?,
      prioritizationFeeLamports: json['prioritizationFeeLamports'] as int?,
      asLegacyTransaction: json['asLegacyTransaction'] as bool?,
      restrictIntermediateTokens: json['restrictIntermediateTokens'] as bool?,
      useTokenLedger: json['useTokenLedger'] as bool?,
      destinationTokenAccount: json['destinationTokenAccount'] as String?,
      dynamicComputeUnitLimit: json['dynamicComputeUnitLimit'] as bool?,
      skipUserAccountsRpcCalls: json['skipUserAccountsRpcCalls'] as bool?,
    );

Map<String, dynamic> _$$JupiterSwapRequestDtoImplToJson(
    _$JupiterSwapRequestDtoImpl instance) {
  final val = <String, dynamic>{
    'userPublicKey': instance.userPublicKey,
    'quoteResponse': instance.quoteResponse.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('wrapAndUnwrapSol', instance.wrapAndUnwrapSol);
  writeNotNull('useSharedAccounts', instance.useSharedAccounts);
  writeNotNull('feeAccount', instance.feeAccount);
  writeNotNull(
      'computeUnitPriceMicroLamports', instance.computeUnitPriceMicroLamports);
  writeNotNull('prioritizationFeeLamports', instance.prioritizationFeeLamports);
  writeNotNull('asLegacyTransaction', instance.asLegacyTransaction);
  writeNotNull(
      'restrictIntermediateTokens', instance.restrictIntermediateTokens);
  writeNotNull('useTokenLedger', instance.useTokenLedger);
  writeNotNull('destinationTokenAccount', instance.destinationTokenAccount);
  writeNotNull('dynamicComputeUnitLimit', instance.dynamicComputeUnitLimit);
  writeNotNull('skipUserAccountsRpcCalls', instance.skipUserAccountsRpcCalls);
  return val;
}

_$JupiterSwapResponseDtoImpl _$$JupiterSwapResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$JupiterSwapResponseDtoImpl(
      swapTransaction: json['swapTransaction'] as String,
      lastValidBlockHeight: json['lastValidBlockHeight'] as int,
    );

Map<String, dynamic> _$$JupiterSwapResponseDtoImplToJson(
        _$JupiterSwapResponseDtoImpl instance) =>
    <String, dynamic>{
      'swapTransaction': instance.swapTransaction,
      'lastValidBlockHeight': instance.lastValidBlockHeight,
    };

_$PriceRequestDtoImpl _$$PriceRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PriceRequestDtoImpl(
      ids: json['ids'] as String,
    );

Map<String, dynamic> _$$PriceRequestDtoImplToJson(
        _$PriceRequestDtoImpl instance) =>
    <String, dynamic>{
      'ids': instance.ids,
    };

_$PriceResponseDtoImpl _$$PriceResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PriceResponseDtoImpl(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, PriceDto.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$PriceResponseDtoImplToJson(
        _$PriceResponseDtoImpl instance) =>
    <String, dynamic>{
      'data': instance.data.map((k, e) => MapEntry(k, e.toJson())),
    };

_$PriceDtoImpl _$$PriceDtoImplFromJson(Map<String, dynamic> json) =>
    _$PriceDtoImpl(
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$$PriceDtoImplToJson(_$PriceDtoImpl instance) =>
    <String, dynamic>{
      'price': instance.price,
    };

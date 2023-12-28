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
    'inAmount': instance.inAmount,
    'outAmount': instance.outAmount,
    'amount': instance.amount,
    'otherAmountThreshold': instance.otherAmountThreshold,
    'slippageBps': instance.slippageBps,
    'priceImpactPct': instance.priceImpactPct,
    'marketInfos': instance.marketInfos.map((e) => e.toJson()).toList(),
    'swapMode': _$SwapModeEnumMap[instance.swapMode]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fees', instance.fees?.toJson());
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
      amount: json['amount'] as String,
      swapMode: $enumDecodeNullable(_$SwapModeEnumMap, json['swapMode']) ??
          SwapMode.exactIn,
      slippageBps: json['slippageBps'] as int?,
      feeBps: json['feeBps'] as int?,
      onlyDirectRoutes: json['onlyDirectRoutes'] as bool?,
      userPublicKey: json['userPublicKey'] as String?,
      asLegacyTransaction: json['asLegacyTransaction'] as bool?,
    );

Map<String, dynamic> _$$QuoteRequestDtoImplToJson(
    _$QuoteRequestDtoImpl instance) {
  final val = <String, dynamic>{
    'inputMint': instance.inputMint,
    'outputMint': instance.outputMint,
    'amount': instance.amount,
    'swapMode': _$SwapModeEnumMap[instance.swapMode]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('slippageBps', instance.slippageBps);
  writeNotNull('feeBps', instance.feeBps);
  writeNotNull('onlyDirectRoutes', instance.onlyDirectRoutes);
  writeNotNull('userPublicKey', instance.userPublicKey);
  writeNotNull('asLegacyTransaction', instance.asLegacyTransaction);
  return val;
}

_$JupiterSwapRequestDtoImpl _$$JupiterSwapRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$JupiterSwapRequestDtoImpl(
      userPublicKey: json['userPublicKey'] as String,
      route: JupiterRoute.fromJson(json['route'] as Map<String, dynamic>),
      wrapUnwrapSOL: json['wrapUnwrapSOL'] as bool?,
      feeAccount: json['feeAccount'] as String?,
      destinationWallet: json['destinationWallet'] as String?,
      asLegacyTransaction: json['asLegacyTransaction'] as bool?,
    );

Map<String, dynamic> _$$JupiterSwapRequestDtoImplToJson(
    _$JupiterSwapRequestDtoImpl instance) {
  final val = <String, dynamic>{
    'userPublicKey': instance.userPublicKey,
    'route': instance.route.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('wrapUnwrapSOL', instance.wrapUnwrapSOL);
  writeNotNull('feeAccount', instance.feeAccount);
  writeNotNull('destinationWallet', instance.destinationWallet);
  writeNotNull('asLegacyTransaction', instance.asLegacyTransaction);
  return val;
}

_$JupiterSwapResponseDtoImpl _$$JupiterSwapResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$JupiterSwapResponseDtoImpl(
      swapTransaction: json['swapTransaction'] as String,
    );

Map<String, dynamic> _$$JupiterSwapResponseDtoImplToJson(
        _$JupiterSwapResponseDtoImpl instance) =>
    <String, dynamic>{
      'swapTransaction': instance.swapTransaction,
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

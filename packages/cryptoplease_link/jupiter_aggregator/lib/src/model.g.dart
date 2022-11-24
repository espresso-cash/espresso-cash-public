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

_$_JupiterSwapResponseDto _$$_JupiterSwapResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_JupiterSwapResponseDto(
      setupTransaction: json['setupTransaction'] as String?,
      swapTransaction: json['swapTransaction'] as String,
      cleanupTransaction: json['cleanupTransaction'] as String?,
    );

Map<String, dynamic> _$$_JupiterSwapResponseDtoToJson(
    _$_JupiterSwapResponseDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('setupTransaction', instance.setupTransaction);
  val['swapTransaction'] = instance.swapTransaction;
  writeNotNull('cleanupTransaction', instance.cleanupTransaction);
  return val;
}

_$_JupiterRoute _$$_JupiterRouteFromJson(Map<String, dynamic> json) =>
    _$_JupiterRoute(
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

Map<String, dynamic> _$$_JupiterRouteToJson(_$_JupiterRoute instance) {
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

_$_JupiterMarket _$$_JupiterMarketFromJson(Map<String, dynamic> json) =>
    _$_JupiterMarket(
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

Map<String, dynamic> _$$_JupiterMarketToJson(_$_JupiterMarket instance) {
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

_$_JupiterMarketFee _$$_JupiterMarketFeeFromJson(Map<String, dynamic> json) =>
    _$_JupiterMarketFee(
      amount: json['amount'] as String,
      mint: json['mint'] as String,
      pct: json['pct'] as num,
    );

Map<String, dynamic> _$$_JupiterMarketFeeToJson(_$_JupiterMarketFee instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'mint': instance.mint,
      'pct': instance.pct,
    };

_$_JupiterRouteFee _$$_JupiterRouteFeeFromJson(Map<String, dynamic> json) =>
    _$_JupiterRouteFee(
      signatureFee: json['signatureFee'] as num,
      openOrdersDeposits: (json['openOrdersDeposits'] as List<dynamic>)
          .map((e) => e as num)
          .toList(),
      ataDeposits:
          (json['ataDeposits'] as List<dynamic>).map((e) => e as num).toList(),
      totalFeeAndDeposits: json['totalFeeAndDeposits'] as num,
      minimumSOLForTransaction: json['minimumSOLForTransaction'] as num,
    );

Map<String, dynamic> _$$_JupiterRouteFeeToJson(_$_JupiterRouteFee instance) =>
    <String, dynamic>{
      'signatureFee': instance.signatureFee,
      'openOrdersDeposits': instance.openOrdersDeposits,
      'ataDeposits': instance.ataDeposits,
      'totalFeeAndDeposits': instance.totalFeeAndDeposits,
      'minimumSOLForTransaction': instance.minimumSOLForTransaction,
    };

_$_QuoteResponseDto _$$_QuoteResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteResponseDto(
      routes: (json['data'] as List<dynamic>)
          .map((e) => JupiterRoute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_QuoteResponseDtoToJson(_$_QuoteResponseDto instance) =>
    <String, dynamic>{
      'data': instance.routes.map((e) => e.toJson()).toList(),
    };

_$_IndexedRouteMapRequestDto _$$_IndexedRouteMapRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_IndexedRouteMapRequestDto(
      onlyDirectRoutes: json['onlyDirectRoutes'] as bool?,
    );

Map<String, dynamic> _$$_IndexedRouteMapRequestDtoToJson(
    _$_IndexedRouteMapRequestDto instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('onlyDirectRoutes', instance.onlyDirectRoutes);
  return val;
}

_$_QuoteRequestDto _$$_QuoteRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_QuoteRequestDto(
      inputMint: json['inputMint'] as String,
      outputMint: json['outputMint'] as String,
      amount: json['amount'] as String,
      swapMode: $enumDecodeNullable(_$SwapModeEnumMap, json['swapMode']) ??
          SwapMode.exactIn,
      slippageBps: json['slippageBps'] as int?,
      feeBps: json['feeBps'] as int?,
      onlyDirectRoutes: json['onlyDirectRoutes'] as bool?,
      userPublicKey: json['userPublicKey'] as String?,
      enforceSingleTx: json['enforceSingleTx'] as bool?,
    );

Map<String, dynamic> _$$_QuoteRequestDtoToJson(_$_QuoteRequestDto instance) {
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
  writeNotNull('enforceSingleTx', instance.enforceSingleTx);
  return val;
}

_$_JupiterSwapRequestDto _$$_JupiterSwapRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_JupiterSwapRequestDto(
      userPublicKey: json['userPublicKey'] as String,
      route: JupiterRoute.fromJson(json['route'] as Map<String, dynamic>),
      wrapUnwrapSOL: json['wrapUnwrapSOL'] as bool?,
      feeAccount: json['feeAccount'] as String?,
      destinationWallet: json['destinationWallet'] as String?,
    );

Map<String, dynamic> _$$_JupiterSwapRequestDtoToJson(
    _$_JupiterSwapRequestDto instance) {
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
  return val;
}

_$_PriceRequestDto _$$_PriceRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_PriceRequestDto(
      id: json['id'] as String,
    );

Map<String, dynamic> _$$_PriceRequestDtoToJson(_$_PriceRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$_PriceResponseDto _$$_PriceResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_PriceResponseDto(
      price: (_readPrice(json, 'data') as num).toDouble(),
    );

Map<String, dynamic> _$$_PriceResponseDtoToJson(_$_PriceResponseDto instance) =>
    <String, dynamic>{
      'data': instance.price,
    };

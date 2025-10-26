// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JupiterMarketFee _$JupiterMarketFeeFromJson(Map<String, dynamic> json) =>
    _JupiterMarketFee(
      amount: json['amount'] as String?,
      feeBps: json['feeBps'] as num?,
    );

Map<String, dynamic> _$JupiterMarketFeeToJson(_JupiterMarketFee instance) =>
    <String, dynamic>{
      if (instance.amount case final value?) 'amount': value,
      if (instance.feeBps case final value?) 'feeBps': value,
    };

_RoutePlan _$RoutePlanFromJson(Map<String, dynamic> json) => _RoutePlan(
  swapInfo: JupiterSwapInfo.fromJson(json['swapInfo'] as Map<String, dynamic>),
  percent: (json['percent'] as num).toInt(),
);

Map<String, dynamic> _$RoutePlanToJson(_RoutePlan instance) =>
    <String, dynamic>{
      'swapInfo': instance.swapInfo.toJson(),
      'percent': instance.percent,
    };

_JupiterSwapInfo _$JupiterSwapInfoFromJson(Map<String, dynamic> json) =>
    _JupiterSwapInfo(
      ammKey: json['ammKey'] as String,
      label: json['label'] as String?,
      inputMint: json['inputMint'] as String,
      outputMint: json['outputMint'] as String,
      inAmount: json['inAmount'] as String,
      outAmount: json['outAmount'] as String,
      feeAmount: json['feeAmount'] as String,
      feeMint: json['feeMint'] as String,
    );

Map<String, dynamic> _$JupiterSwapInfoToJson(_JupiterSwapInfo instance) =>
    <String, dynamic>{
      'ammKey': instance.ammKey,
      if (instance.label case final value?) 'label': value,
      'inputMint': instance.inputMint,
      'outputMint': instance.outputMint,
      'inAmount': instance.inAmount,
      'outAmount': instance.outAmount,
      'feeAmount': instance.feeAmount,
      'feeMint': instance.feeMint,
    };

_QuoteResponseDto _$QuoteResponseDtoFromJson(Map<String, dynamic> json) =>
    _QuoteResponseDto(
      inputMint: json['inputMint'] as String,
      inAmount: json['inAmount'] as String,
      outputMint: json['outputMint'] as String,
      outAmount: json['outAmount'] as String,
      otherAmountThreshold: json['otherAmountThreshold'] as String,
      swapMode:
          $enumDecodeNullable(_$SwapModeEnumMap, json['swapMode']) ??
          SwapMode.exactIn,
      slippageBps: (json['slippageBps'] as num).toInt(),
      platformFee:
          json['platformFee'] == null
              ? null
              : JupiterMarketFee.fromJson(
                json['platformFee'] as Map<String, dynamic>,
              ),
      priceImpactPct: json['priceImpactPct'] as String,
      routePlan:
          (json['routePlan'] as List<dynamic>)
              .map((e) => RoutePlan.fromJson(e as Map<String, dynamic>))
              .toList(),
      contextSlot: json['contextSlot'] as num?,
      timeTaken: (json['timeTaken'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$QuoteResponseDtoToJson(
  _QuoteResponseDto instance,
) => <String, dynamic>{
  'inputMint': instance.inputMint,
  'inAmount': instance.inAmount,
  'outputMint': instance.outputMint,
  'outAmount': instance.outAmount,
  'otherAmountThreshold': instance.otherAmountThreshold,
  'swapMode': _$SwapModeEnumMap[instance.swapMode]!,
  'slippageBps': instance.slippageBps,
  if (instance.platformFee?.toJson() case final value?) 'platformFee': value,
  'priceImpactPct': instance.priceImpactPct,
  'routePlan': instance.routePlan.map((e) => e.toJson()).toList(),
  if (instance.contextSlot case final value?) 'contextSlot': value,
  if (instance.timeTaken case final value?) 'timeTaken': value,
};

const _$SwapModeEnumMap = {
  SwapMode.exactIn: 'ExactIn',
  SwapMode.exactOut: 'ExactOut',
};

_QuoteRequestDto _$QuoteRequestDtoFromJson(Map<String, dynamic> json) =>
    _QuoteRequestDto(
      inputMint: json['inputMint'] as String,
      outputMint: json['outputMint'] as String,
      amount: (json['amount'] as num).toInt(),
      slippageBps: (json['slippageBps'] as num?)?.toInt(),
      swapMode:
          $enumDecodeNullable(_$SwapModeEnumMap, json['swapMode']) ??
          SwapMode.exactIn,
      dexes:
          (json['dexes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      excludeDexes:
          (json['excludeDexes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
      onlyDirectRoutes: json['onlyDirectRoutes'] as bool?,
      asLegacyTransaction: json['asLegacyTransaction'] as bool?,
      platformFeeBps: (json['platformFeeBps'] as num?)?.toInt(),
      maxAccounts: (json['maxAccounts'] as num?)?.toInt(),
      restrictIntermediateTokens: json['restrictIntermediateTokens'] as bool?,
      autoSlippage: json['autoSlippage'] as bool?,
      maxAutoSlippageBps: (json['maxAutoSlippageBps'] as num?)?.toInt(),
      autoSlippageCollisionUsdValue:
          (json['autoSlippageCollisionUsdValue'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QuoteRequestDtoToJson(
  _QuoteRequestDto instance,
) => <String, dynamic>{
  'inputMint': instance.inputMint,
  'outputMint': instance.outputMint,
  'amount': instance.amount,
  if (instance.slippageBps case final value?) 'slippageBps': value,
  'swapMode': _$SwapModeEnumMap[instance.swapMode]!,
  if (instance.dexes case final value?) 'dexes': value,
  if (instance.excludeDexes case final value?) 'excludeDexes': value,
  if (instance.onlyDirectRoutes case final value?) 'onlyDirectRoutes': value,
  if (instance.asLegacyTransaction case final value?)
    'asLegacyTransaction': value,
  if (instance.platformFeeBps case final value?) 'platformFeeBps': value,
  if (instance.maxAccounts case final value?) 'maxAccounts': value,
  if (instance.restrictIntermediateTokens case final value?)
    'restrictIntermediateTokens': value,
  if (instance.autoSlippage case final value?) 'autoSlippage': value,
  if (instance.maxAutoSlippageBps case final value?)
    'maxAutoSlippageBps': value,
  if (instance.autoSlippageCollisionUsdValue case final value?)
    'autoSlippageCollisionUsdValue': value,
};

_JupiterSwapRequestDto _$JupiterSwapRequestDtoFromJson(
  Map<String, dynamic> json,
) => _JupiterSwapRequestDto(
  userPublicKey: json['userPublicKey'] as String,
  quoteResponse: QuoteResponseDto.fromJson(
    json['quoteResponse'] as Map<String, dynamic>,
  ),
  wrapAndUnwrapSol: json['wrapAndUnwrapSol'] as bool? ?? true,
  useSharedAccounts: json['useSharedAccounts'] as bool? ?? true,
  feeAccount: json['feeAccount'] as String?,
  computeUnitPriceMicroLamports:
      (json['computeUnitPriceMicroLamports'] as num?)?.toInt(),
  prioritizationFeeLamports:
      (json['prioritizationFeeLamports'] as num?)?.toInt(),
  asLegacyTransaction: json['asLegacyTransaction'] as bool?,
  restrictIntermediateTokens: json['restrictIntermediateTokens'] as bool?,
  useTokenLedger: json['useTokenLedger'] as bool?,
  destinationTokenAccount: json['destinationTokenAccount'] as String?,
  dynamicComputeUnitLimit: json['dynamicComputeUnitLimit'] as bool?,
  skipUserAccountsRpcCalls: json['skipUserAccountsRpcCalls'] as bool?,
  trackingAccount: json['trackingAccount'] as String?,
  dynamicSlippage:
      json['dynamicSlippage'] == null
          ? null
          : DynamicSlippage.fromJson(
            json['dynamicSlippage'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$JupiterSwapRequestDtoToJson(
  _JupiterSwapRequestDto instance,
) => <String, dynamic>{
  'userPublicKey': instance.userPublicKey,
  'quoteResponse': instance.quoteResponse.toJson(),
  if (instance.wrapAndUnwrapSol case final value?) 'wrapAndUnwrapSol': value,
  if (instance.useSharedAccounts case final value?) 'useSharedAccounts': value,
  if (instance.feeAccount case final value?) 'feeAccount': value,
  if (instance.computeUnitPriceMicroLamports case final value?)
    'computeUnitPriceMicroLamports': value,
  if (instance.prioritizationFeeLamports case final value?)
    'prioritizationFeeLamports': value,
  if (instance.asLegacyTransaction case final value?)
    'asLegacyTransaction': value,
  if (instance.restrictIntermediateTokens case final value?)
    'restrictIntermediateTokens': value,
  if (instance.useTokenLedger case final value?) 'useTokenLedger': value,
  if (instance.destinationTokenAccount case final value?)
    'destinationTokenAccount': value,
  if (instance.dynamicComputeUnitLimit case final value?)
    'dynamicComputeUnitLimit': value,
  if (instance.skipUserAccountsRpcCalls case final value?)
    'skipUserAccountsRpcCalls': value,
  if (instance.trackingAccount case final value?) 'trackingAccount': value,
  if (instance.dynamicSlippage?.toJson() case final value?)
    'dynamicSlippage': value,
};

_DynamicSlippage _$DynamicSlippageFromJson(Map<String, dynamic> json) =>
    _DynamicSlippage(
      minBps: (json['minBps'] as num).toInt(),
      maxBps: (json['maxBps'] as num).toInt(),
    );

Map<String, dynamic> _$DynamicSlippageToJson(_DynamicSlippage instance) =>
    <String, dynamic>{'minBps': instance.minBps, 'maxBps': instance.maxBps};

_JupiterSwapResponseDto _$JupiterSwapResponseDtoFromJson(
  Map<String, dynamic> json,
) => _JupiterSwapResponseDto(
  swapTransaction: json['swapTransaction'] as String,
  lastValidBlockHeight: (json['lastValidBlockHeight'] as num).toInt(),
  prioritizationFeeLamports:
      (json['prioritizationFeeLamports'] as num?)?.toInt(),
  dynamicSlippageReport:
      json['dynamicSlippageReport'] == null
          ? null
          : DynamicSlippageReport.fromJson(
            json['dynamicSlippageReport'] as Map<String, dynamic>,
          ),
);

Map<String, dynamic> _$JupiterSwapResponseDtoToJson(
  _JupiterSwapResponseDto instance,
) => <String, dynamic>{
  'swapTransaction': instance.swapTransaction,
  'lastValidBlockHeight': instance.lastValidBlockHeight,
  if (instance.prioritizationFeeLamports case final value?)
    'prioritizationFeeLamports': value,
  if (instance.dynamicSlippageReport?.toJson() case final value?)
    'dynamicSlippageReport': value,
};

_DynamicSlippageReport _$DynamicSlippageReportFromJson(
  Map<String, dynamic> json,
) => _DynamicSlippageReport(
  slippageBps: (json['slippageBps'] as num?)?.toInt(),
  otherAmount: (json['otherAmount'] as num?)?.toInt(),
  simulatedIncurredSlippageBps:
      (json['simulatedIncurredSlippageBps'] as num?)?.toInt(),
  amplificationRatio: json['amplificationRatio'] as String?,
);

Map<String, dynamic> _$DynamicSlippageReportToJson(
  _DynamicSlippageReport instance,
) => <String, dynamic>{
  if (instance.slippageBps case final value?) 'slippageBps': value,
  if (instance.otherAmount case final value?) 'otherAmount': value,
  if (instance.simulatedIncurredSlippageBps case final value?)
    'simulatedIncurredSlippageBps': value,
  if (instance.amplificationRatio case final value?)
    'amplificationRatio': value,
};

_PriceRequestDto _$PriceRequestDtoFromJson(Map<String, dynamic> json) =>
    _PriceRequestDto(
      ids: (json['ids'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PriceRequestDtoToJson(_PriceRequestDto instance) =>
    <String, dynamic>{'ids': _listToString(instance.ids)};

_PriceResponseDto _$PriceResponseDtoFromJson(Map<String, dynamic> json) =>
    _PriceResponseDto(
      data: (json['data'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, PriceDto.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$PriceResponseDtoToJson(_PriceResponseDto instance) =>
    <String, dynamic>{
      'data': instance.data.map((k, e) => MapEntry(k, e.toJson())),
    };

_PriceDto _$PriceDtoFromJson(Map<String, dynamic> json) =>
    _PriceDto(price: json['price'] as String?);

Map<String, dynamic> _$PriceDtoToJson(_PriceDto instance) => <String, dynamic>{
  if (instance.price case final value?) 'price': value,
};

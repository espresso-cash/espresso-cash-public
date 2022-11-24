// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SwapRouteRequestDto _$$_SwapRouteRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_SwapRouteRequestDto(
      inputToken: json['inputToken'] as String,
      outputToken: json['outputToken'] as String,
      amount: json['amount'] as String,
      match: $enumDecode(_$SwapMatchEnumMap, json['match']),
      slippage: $enumDecode(_$SwapSlippageEnumMap, json['slippage']),
      userAccount: json['userAccount'] as String,
    );

Map<String, dynamic> _$$_SwapRouteRequestDtoToJson(
        _$_SwapRouteRequestDto instance) =>
    <String, dynamic>{
      'inputToken': instance.inputToken,
      'outputToken': instance.outputToken,
      'amount': instance.amount,
      'match': _$SwapMatchEnumMap[instance.match]!,
      'slippage': _$SwapSlippageEnumMap[instance.slippage]!,
      'userAccount': instance.userAccount,
    };

const _$SwapMatchEnumMap = {
  SwapMatch.inAmount: 'inAmount',
  SwapMatch.outAmount: 'outAmount',
};

const _$SwapSlippageEnumMap = {
  SwapSlippage.zpOne: 'zpOne',
  SwapSlippage.zpFive: 'zpFive',
  SwapSlippage.onePercent: 'onePercent',
};

_$_SwapRouteResponseDto _$$_SwapRouteResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_SwapRouteResponseDto(
      bestRoute: json['bestRoute'] == null
          ? null
          : JupiterRoute.fromJson(json['bestRoute'] as Map<String, dynamic>),
      feeInUsdc: json['feeInUsdc'] as int,
    );

Map<String, dynamic> _$$_SwapRouteResponseDtoToJson(
        _$_SwapRouteResponseDto instance) =>
    <String, dynamic>{
      'bestRoute': instance.bestRoute,
      'feeInUsdc': instance.feeInUsdc,
    };

_$_SwapTxResponseDto _$$_SwapTxResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_SwapTxResponseDto(
      swapTransaction: json['swapTransaction'] as String,
    );

Map<String, dynamic> _$$_SwapTxResponseDtoToJson(
        _$_SwapTxResponseDto instance) =>
    <String, dynamic>{
      'swapTransaction': instance.swapTransaction,
    };

_$_SwapTxRequestDto _$$_SwapTxRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_SwapTxRequestDto(
      userAccount: json['userAccount'] as String,
      route: JupiterRoute.fromJson(json['route'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SwapTxRequestDtoToJson(_$_SwapTxRequestDto instance) =>
    <String, dynamic>{
      'userAccount': instance.userAccount,
      'route': instance.route,
    };

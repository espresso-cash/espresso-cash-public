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
      asLegacyTx: json['asLegacyTx'] as bool? ?? true,
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
      'asLegacyTx': instance.asLegacyTx,
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
      inAmount: json['inAmount'] as String,
      outAmount: json['outAmount'] as String,
      amount: json['amount'] as String,
      encodedTx: json['encodedTx'] as String,
      feeInUsdc: json['feeInUsdc'] as int,
    );

Map<String, dynamic> _$$_SwapRouteResponseDtoToJson(
        _$_SwapRouteResponseDto instance) =>
    <String, dynamic>{
      'inAmount': instance.inAmount,
      'outAmount': instance.outAmount,
      'amount': instance.amount,
      'encodedTx': instance.encodedTx,
      'feeInUsdc': instance.feeInUsdc,
    };

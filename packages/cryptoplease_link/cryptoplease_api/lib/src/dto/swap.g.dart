// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SwapResponseDto _$$_SwapResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_SwapResponseDto(
      swapTransaction: json['swapTransaction'] as String,
    );

Map<String, dynamic> _$$_SwapResponseDtoToJson(_$_SwapResponseDto instance) =>
    <String, dynamic>{
      'swapTransaction': instance.swapTransaction,
    };

_$_SwapRequestDto _$$_SwapRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_SwapRequestDto(
      userPublicKey: json['userPublicKey'] as String,
      route: JupiterRoute.fromJson(json['route'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SwapRequestDtoToJson(_$_SwapRequestDto instance) =>
    <String, dynamic>{
      'userPublicKey': instance.userPublicKey,
      'route': instance.route,
    };

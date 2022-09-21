// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'limit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LimitResponseDto _$$_LimitResponseDtoFromJson(Map<String, dynamic> json) =>
    _$_LimitResponseDto(
      minAmount: (json['minAmount'] as num).toDouble(),
    );

Map<String, dynamic> _$$_LimitResponseDtoToJson(_$_LimitResponseDto instance) =>
    <String, dynamic>{
      'minAmount': instance.minAmount,
    };

_$_LimitRequestDto _$$_LimitRequestDtoFromJson(Map<String, dynamic> json) =>
    _$_LimitRequestDto(
      tokenSymbol: json['tokenSymbol'] as String,
    );

Map<String, dynamic> _$$_LimitRequestDtoToJson(_$_LimitRequestDto instance) =>
    <String, dynamic>{
      'tokenSymbol': instance.tokenSymbol,
    };

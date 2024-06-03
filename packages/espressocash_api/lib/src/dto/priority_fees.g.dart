// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PriorityFeesRequestDtoImpl _$$PriorityFeesRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PriorityFeesRequestDtoImpl(
      encodedTx: json['encodedTx'] as String,
    );

Map<String, dynamic> _$$PriorityFeesRequestDtoImplToJson(
        _$PriorityFeesRequestDtoImpl instance) =>
    <String, dynamic>{
      'encodedTx': instance.encodedTx,
    };

_$PriorityFeesResponseDtoImpl _$$PriorityFeesResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$PriorityFeesResponseDtoImpl(
      none: json['none'] as int?,
      low: json['low'] as int?,
      medium: json['medium'] as int?,
      high: json['high'] as int?,
      veryHigh: json['veryHigh'] as int?,
      unsafeMax: json['unsafeMax'] as int?,
    );

Map<String, dynamic> _$$PriorityFeesResponseDtoImplToJson(
        _$PriorityFeesResponseDtoImpl instance) =>
    <String, dynamic>{
      'none': instance.none,
      'low': instance.low,
      'medium': instance.medium,
      'high': instance.high,
      'veryHigh': instance.veryHigh,
      'unsafeMax': instance.unsafeMax,
    };

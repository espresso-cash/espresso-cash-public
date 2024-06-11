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
      none: (json['none'] as num?)?.toInt(),
      low: (json['low'] as num?)?.toInt(),
      medium: (json['medium'] as num?)?.toInt(),
      high: (json['high'] as num?)?.toInt(),
      veryHigh: (json['veryHigh'] as num?)?.toInt(),
      unsafeMax: (json['unsafeMax'] as num?)?.toInt(),
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

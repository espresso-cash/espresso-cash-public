// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inflation_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InflationRate _$InflationRateFromJson(Map<String, dynamic> json) =>
    InflationRate(
      total: (json['total'] as num).toDouble(),
      validator: (json['validator'] as num).toDouble(),
      foundation: (json['foundation'] as num).toDouble(),
      epoch: (json['epoch'] as num).toDouble(),
    );

Map<String, dynamic> _$InflationRateToJson(InflationRate instance) =>
    <String, dynamic>{
      'total': instance.total,
      'validator': instance.validator,
      'foundation': instance.foundation,
      'epoch': instance.epoch,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GasFeeRequestDtoImpl _$$GasFeeRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GasFeeRequestDtoImpl(
      network: json['network'] as String,
    );

Map<String, dynamic> _$$GasFeeRequestDtoImplToJson(
        _$GasFeeRequestDtoImpl instance) =>
    <String, dynamic>{
      'network': instance.network,
    };

_$GasFeeResponseDtoImpl _$$GasFeeResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GasFeeResponseDtoImpl(
      low: GasFeeEstimate.fromJson(json['low'] as Map<String, dynamic>),
      medium: GasFeeEstimate.fromJson(json['medium'] as Map<String, dynamic>),
      high: GasFeeEstimate.fromJson(json['high'] as Map<String, dynamic>),
      estimatedBaseFee: json['estimatedBaseFee'] as String,
      networkCongestion: (json['networkCongestion'] as num).toDouble(),
      latestPriorityFeeRange: (json['latestPriorityFeeRange'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      historicalPriorityFeeRange:
          (json['historicalPriorityFeeRange'] as List<dynamic>)
              .map((e) => e as String)
              .toList(),
      historicalBaseFeeRange: (json['historicalBaseFeeRange'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      priorityFeeTrend: json['priorityFeeTrend'] as String,
      baseFeeTrend: json['baseFeeTrend'] as String,
    );

Map<String, dynamic> _$$GasFeeResponseDtoImplToJson(
        _$GasFeeResponseDtoImpl instance) =>
    <String, dynamic>{
      'low': instance.low,
      'medium': instance.medium,
      'high': instance.high,
      'estimatedBaseFee': instance.estimatedBaseFee,
      'networkCongestion': instance.networkCongestion,
      'latestPriorityFeeRange': instance.latestPriorityFeeRange,
      'historicalPriorityFeeRange': instance.historicalPriorityFeeRange,
      'historicalBaseFeeRange': instance.historicalBaseFeeRange,
      'priorityFeeTrend': instance.priorityFeeTrend,
      'baseFeeTrend': instance.baseFeeTrend,
    };

_$GasFeeEstimateImpl _$$GasFeeEstimateImplFromJson(Map<String, dynamic> json) =>
    _$GasFeeEstimateImpl(
      suggestedMaxPriorityFeePerGas:
          json['suggestedMaxPriorityFeePerGas'] as String,
      suggestedMaxFeePerGas: json['suggestedMaxFeePerGas'] as String,
      minWaitTimeEstimate: json['minWaitTimeEstimate'] as int,
      maxWaitTimeEstimate: json['maxWaitTimeEstimate'] as int,
    );

Map<String, dynamic> _$$GasFeeEstimateImplToJson(
        _$GasFeeEstimateImpl instance) =>
    <String, dynamic>{
      'suggestedMaxPriorityFeePerGas': instance.suggestedMaxPriorityFeePerGas,
      'suggestedMaxFeePerGas': instance.suggestedMaxFeePerGas,
      'minWaitTimeEstimate': instance.minWaitTimeEstimate,
      'maxWaitTimeEstimate': instance.maxWaitTimeEstimate,
    };

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
    );

Map<String, dynamic> _$$GasFeeResponseDtoImplToJson(
        _$GasFeeResponseDtoImpl instance) =>
    <String, dynamic>{
      'low': instance.low,
      'medium': instance.medium,
      'high': instance.high,
      'estimatedBaseFee': instance.estimatedBaseFee,
      'networkCongestion': instance.networkCongestion,
    };

_$GasFeeEstimateImpl _$$GasFeeEstimateImplFromJson(Map<String, dynamic> json) =>
    _$GasFeeEstimateImpl(
      suggestedMaxPriorityFeePerGas:
          json['suggestedMaxPriorityFeePerGas'] as String,
      suggestedMaxFeePerGas: json['suggestedMaxFeePerGas'] as String,
      minWaitTimeEstimate: (json['minWaitTimeEstimate'] as num).toInt(),
      maxWaitTimeEstimate: (json['maxWaitTimeEstimate'] as num).toInt(),
    );

Map<String, dynamic> _$$GasFeeEstimateImplToJson(
        _$GasFeeEstimateImpl instance) =>
    <String, dynamic>{
      'suggestedMaxPriorityFeePerGas': instance.suggestedMaxPriorityFeePerGas,
      'suggestedMaxFeePerGas': instance.suggestedMaxFeePerGas,
      'minWaitTimeEstimate': instance.minWaitTimeEstimate,
      'maxWaitTimeEstimate': instance.maxWaitTimeEstimate,
    };

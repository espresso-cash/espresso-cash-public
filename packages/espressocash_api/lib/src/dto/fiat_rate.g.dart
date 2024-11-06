// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fiat_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FiatRateRequestDtoImpl _$$FiatRateRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$FiatRateRequestDtoImpl(
      base: json['base'] as String? ?? 'USD',
      target: json['target'] as String,
    );

Map<String, dynamic> _$$FiatRateRequestDtoImplToJson(
        _$FiatRateRequestDtoImpl instance) =>
    <String, dynamic>{
      'base': instance.base,
      'target': instance.target,
    };

_$FiatRateResponseDtoImpl _$$FiatRateResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$FiatRateResponseDtoImpl(
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$FiatRateResponseDtoImplToJson(
        _$FiatRateResponseDtoImpl instance) =>
    <String, dynamic>{
      'rate': instance.rate,
    };

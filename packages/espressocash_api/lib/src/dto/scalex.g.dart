// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scalex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GenerateScalexLinkResponseDtoImpl
    _$$GenerateScalexLinkResponseDtoImplFromJson(Map<String, dynamic> json) =>
        _$GenerateScalexLinkResponseDtoImpl(
          signedUrl: json['signedUrl'] as String,
        );

Map<String, dynamic> _$$GenerateScalexLinkResponseDtoImplToJson(
        _$GenerateScalexLinkResponseDtoImpl instance) =>
    <String, dynamic>{
      'signedUrl': instance.signedUrl,
    };

_$GenerateScalexLinkRequestDtoImpl _$$GenerateScalexLinkRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GenerateScalexLinkRequestDtoImpl(
      type: json['type'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$GenerateScalexLinkRequestDtoImplToJson(
        _$GenerateScalexLinkRequestDtoImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'address': instance.address,
      'email': instance.email,
    };

_$OrderStatusScalexRequestDtoImpl _$$OrderStatusScalexRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderStatusScalexRequestDtoImpl(
      referenceId: json['referenceId'] as String,
    );

Map<String, dynamic> _$$OrderStatusScalexRequestDtoImplToJson(
        _$OrderStatusScalexRequestDtoImpl instance) =>
    <String, dynamic>{
      'referenceId': instance.referenceId,
    };

_$OrderStatusScalexResponseDtoImpl _$$OrderStatusScalexResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$OrderStatusScalexResponseDtoImpl(
      status: $enumDecode(_$ScalexOrderStatusEnumMap, json['status'],
          unknownValue: ScalexOrderStatus.unknown),
      onRampDetails: json['onRampDetails'] == null
          ? null
          : OnRampScalexDetails.fromJson(
              json['onRampDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderStatusScalexResponseDtoImplToJson(
        _$OrderStatusScalexResponseDtoImpl instance) =>
    <String, dynamic>{
      'status': _$ScalexOrderStatusEnumMap[instance.status]!,
      'onRampDetails': instance.onRampDetails,
    };

const _$ScalexOrderStatusEnumMap = {
  ScalexOrderStatus.pending: 'pending',
  ScalexOrderStatus.completed: 'completed',
  ScalexOrderStatus.expired: 'expired',
  ScalexOrderStatus.failed: 'failed',
  ScalexOrderStatus.unknown: 'unknown',
};

_$OnRampScalexDetailsImpl _$$OnRampScalexDetailsImplFromJson(
        Map<String, dynamic> json) =>
    _$OnRampScalexDetailsImpl(
      currency: json['currency'] as String,
      bankName: json['bankName'] as String,
      bankAccount: json['bankAccount'] as String,
      fromAmount: json['fromAmount'] as num,
      fiatCurrency: json['fiatCurrency'] as String,
    );

Map<String, dynamic> _$$OnRampScalexDetailsImplToJson(
        _$OnRampScalexDetailsImpl instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'bankName': instance.bankName,
      'bankAccount': instance.bankAccount,
      'fromAmount': instance.fromAmount,
      'fiatCurrency': instance.fiatCurrency,
    };

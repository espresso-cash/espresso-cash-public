// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scalex.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GenerateScalexLinkResponseDto _$$_GenerateScalexLinkResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateScalexLinkResponseDto(
      signedUrl: json['signedUrl'] as String,
    );

Map<String, dynamic> _$$_GenerateScalexLinkResponseDtoToJson(
        _$_GenerateScalexLinkResponseDto instance) =>
    <String, dynamic>{
      'signedUrl': instance.signedUrl,
    };

_$_GenerateScalexLinkRequestDto _$$_GenerateScalexLinkRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GenerateScalexLinkRequestDto(
      type: json['type'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$_GenerateScalexLinkRequestDtoToJson(
        _$_GenerateScalexLinkRequestDto instance) =>
    <String, dynamic>{
      'type': instance.type,
      'address': instance.address,
      'email': instance.email,
    };

_$_OrderStatusScalexRequestDto _$$_OrderStatusScalexRequestDtoFromJson(
        Map<String, dynamic> json) =>
    _$_OrderStatusScalexRequestDto(
      referenceId: json['referenceId'] as String,
    );

Map<String, dynamic> _$$_OrderStatusScalexRequestDtoToJson(
        _$_OrderStatusScalexRequestDto instance) =>
    <String, dynamic>{
      'referenceId': instance.referenceId,
    };

_$_OrderStatusScalexResponseDto _$$_OrderStatusScalexResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_OrderStatusScalexResponseDto(
      status: $enumDecode(_$ScalexOrderStatusEnumMap, json['status'],
          unknownValue: ScalexOrderStatus.unknown),
      onRampDetails: json['onRampDetails'] == null
          ? null
          : OnRampScalexDetails.fromJson(
              json['onRampDetails'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_OrderStatusScalexResponseDtoToJson(
        _$_OrderStatusScalexResponseDto instance) =>
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

_$_OnRampScalexDetails _$$_OnRampScalexDetailsFromJson(
        Map<String, dynamic> json) =>
    _$_OnRampScalexDetails(
      currency: json['currency'] as String,
      bankName: json['bankName'] as String,
      bankAccount: json['bankAccount'] as String,
      fromAmount: json['fromAmount'] as num,
    );

Map<String, dynamic> _$$_OnRampScalexDetailsToJson(
        _$_OnRampScalexDetails instance) =>
    <String, dynamic>{
      'currency': instance.currency,
      'bankName': instance.bankName,
      'bankAccount': instance.bankAccount,
      'fromAmount': instance.fromAmount,
    };

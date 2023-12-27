// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetFeesResponseDtoImpl _$$GetFeesResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$GetFeesResponseDtoImpl(
      directPayment: DirectPaymentFeeDto.fromJson(
          json['directPayment'] as Map<String, dynamic>),
      splitKeyPayment: json['splitKeyPayment'] as int,
      escrowPayment: json['escrowPayment'] as int,
    );

Map<String, dynamic> _$$GetFeesResponseDtoImplToJson(
        _$GetFeesResponseDtoImpl instance) =>
    <String, dynamic>{
      'directPayment': instance.directPayment,
      'splitKeyPayment': instance.splitKeyPayment,
      'escrowPayment': instance.escrowPayment,
    };

_$DirectPaymentFeeDtoImpl _$$DirectPaymentFeeDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$DirectPaymentFeeDtoImpl(
      ataExists: json['ataExists'] as int,
      ataDoesNotExist: json['ataDoesNotExist'] as int,
    );

Map<String, dynamic> _$$DirectPaymentFeeDtoImplToJson(
        _$DirectPaymentFeeDtoImpl instance) =>
    <String, dynamic>{
      'ataExists': instance.ataExists,
      'ataDoesNotExist': instance.ataDoesNotExist,
    };

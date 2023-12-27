// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetFeesResponseDto _$$_GetFeesResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GetFeesResponseDto(
      directPayment: DirectPaymentFeeDto.fromJson(
          json['directPayment'] as Map<String, dynamic>),
      splitKeyPayment: json['splitKeyPayment'] as int,
      escrowPayment: json['escrowPayment'] as int,
    );

Map<String, dynamic> _$$_GetFeesResponseDtoToJson(
        _$_GetFeesResponseDto instance) =>
    <String, dynamic>{
      'directPayment': instance.directPayment,
      'splitKeyPayment': instance.splitKeyPayment,
      'escrowPayment': instance.escrowPayment,
    };

_$_DirectPaymentFeeDto _$$_DirectPaymentFeeDtoFromJson(
        Map<String, dynamic> json) =>
    _$_DirectPaymentFeeDto(
      ataExists: json['ataExists'] as int,
      ataDoesNotExist: json['ataDoesNotExist'] as int,
    );

Map<String, dynamic> _$$_DirectPaymentFeeDtoToJson(
        _$_DirectPaymentFeeDto instance) =>
    <String, dynamic>{
      'ataExists': instance.ataExists,
      'ataDoesNotExist': instance.ataDoesNotExist,
    };

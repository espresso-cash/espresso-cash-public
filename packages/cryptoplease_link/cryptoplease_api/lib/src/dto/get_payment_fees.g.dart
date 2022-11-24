// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_fees.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetPaymentFeesResponseDto _$$_GetPaymentFeesResponseDtoFromJson(
        Map<String, dynamic> json) =>
    _$_GetPaymentFeesResponseDto(
      directPayment: DirectPaymentFeeDto.fromJson(
          json['directPayment'] as Map<String, dynamic>),
      splitKeyPayment: json['splitKeyPayment'] as int,
    );

Map<String, dynamic> _$$_GetPaymentFeesResponseDtoToJson(
        _$_GetPaymentFeesResponseDto instance) =>
    <String, dynamic>{
      'directPayment': instance.directPayment,
      'splitKeyPayment': instance.splitKeyPayment,
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

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
      escrowPayment: json['escrowPayment'] as int,
      escrowPaymentAtaFee: json['escrowPaymentAtaFee'] as int,
      splitKeyPayment: json['splitKeyPayment'] as int,
      withdrawalFee: WithdrawFeeDto.fromJson(
          json['withdrawalFee'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetFeesResponseDtoImplToJson(
        _$GetFeesResponseDtoImpl instance) =>
    <String, dynamic>{
      'directPayment': instance.directPayment,
      'escrowPayment': instance.escrowPayment,
      'escrowPaymentAtaFee': instance.escrowPaymentAtaFee,
      'splitKeyPayment': instance.splitKeyPayment,
      'withdrawalFee': instance.withdrawalFee,
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

_$WithdrawFeeDtoImpl _$$WithdrawFeeDtoImplFromJson(Map<String, dynamic> json) =>
    _$WithdrawFeeDtoImpl(
      scalexFee: json['scalexFee'] as int,
    );

Map<String, dynamic> _$$WithdrawFeeDtoImplToJson(
        _$WithdrawFeeDtoImpl instance) =>
    <String, dynamic>{
      'scalexFee': instance.scalexFee,
    };

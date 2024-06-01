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
      escrowPayment: (json['escrowPayment'] as num).toInt(),
      escrowPaymentAtaFee: (json['escrowPaymentAtaFee'] as num).toInt(),
      splitKeyPayment: (json['splitKeyPayment'] as num).toInt(),
      withdrawFeePercentage: json['withdrawFeePercentage'] == null
          ? const WithdrawFeeDto()
          : WithdrawFeeDto.fromJson(
              json['withdrawFeePercentage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetFeesResponseDtoImplToJson(
        _$GetFeesResponseDtoImpl instance) =>
    <String, dynamic>{
      'directPayment': instance.directPayment,
      'escrowPayment': instance.escrowPayment,
      'escrowPaymentAtaFee': instance.escrowPaymentAtaFee,
      'splitKeyPayment': instance.splitKeyPayment,
      'withdrawFeePercentage': instance.withdrawFeePercentage,
    };

_$DirectPaymentFeeDtoImpl _$$DirectPaymentFeeDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$DirectPaymentFeeDtoImpl(
      ataExists: (json['ataExists'] as num).toInt(),
      ataDoesNotExist: (json['ataDoesNotExist'] as num).toInt(),
    );

Map<String, dynamic> _$$DirectPaymentFeeDtoImplToJson(
        _$DirectPaymentFeeDtoImpl instance) =>
    <String, dynamic>{
      'ataExists': instance.ataExists,
      'ataDoesNotExist': instance.ataDoesNotExist,
    };

_$WithdrawFeeDtoImpl _$$WithdrawFeeDtoImplFromJson(Map<String, dynamic> json) =>
    _$WithdrawFeeDtoImpl(
      scalex: (json['scalex'] as num?)?.toDouble() ?? 0,
      kado: (json['kado'] as num?)?.toDouble() ?? 0,
      rampNetwork: (json['rampNetwork'] as num?)?.toDouble() ?? 0,
      coinflow: (json['coinflow'] as num?)?.toDouble() ?? 0,
      guardarian: (json['guardarian'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$WithdrawFeeDtoImplToJson(
        _$WithdrawFeeDtoImpl instance) =>
    <String, dynamic>{
      'scalex': instance.scalex,
      'kado': instance.kado,
      'rampNetwork': instance.rampNetwork,
      'coinflow': instance.coinflow,
      'guardarian': instance.guardarian,
    };

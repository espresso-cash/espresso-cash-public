// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambassador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AmbassadorReferralRequestDtoImpl _$$AmbassadorReferralRequestDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$AmbassadorReferralRequestDtoImpl(
      ambassadorAddress: json['ambassadorAddress'] as String,
    );

Map<String, dynamic> _$$AmbassadorReferralRequestDtoImplToJson(
        _$AmbassadorReferralRequestDtoImpl instance) =>
    <String, dynamic>{
      'ambassadorAddress': instance.ambassadorAddress,
    };

_$AmbassadorStatsResponseDtoImpl _$$AmbassadorStatsResponseDtoImplFromJson(
        Map<String, dynamic> json) =>
    _$AmbassadorStatsResponseDtoImpl(
      referralCount: (json['referralCount'] as num).toInt(),
    );

Map<String, dynamic> _$$AmbassadorStatsResponseDtoImplToJson(
        _$AmbassadorStatsResponseDtoImpl instance) =>
    <String, dynamic>{
      'referralCount': instance.referralCount,
    };

_$AmbassadorVerificationRequestDtoImpl
    _$$AmbassadorVerificationRequestDtoImplFromJson(
            Map<String, dynamic> json) =>
        _$AmbassadorVerificationRequestDtoImpl(
          address: json['address'] as String,
        );

Map<String, dynamic> _$$AmbassadorVerificationRequestDtoImplToJson(
        _$AmbassadorVerificationRequestDtoImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
    };

_$AmbassadorVerificationResponseDtoImpl
    _$$AmbassadorVerificationResponseDtoImplFromJson(
            Map<String, dynamic> json) =>
        _$AmbassadorVerificationResponseDtoImpl(
          isAmbassador: json['isAmbassador'] as bool,
        );

Map<String, dynamic> _$$AmbassadorVerificationResponseDtoImplToJson(
        _$AmbassadorVerificationResponseDtoImpl instance) =>
    <String, dynamic>{
      'isAmbassador': instance.isAmbassador,
    };

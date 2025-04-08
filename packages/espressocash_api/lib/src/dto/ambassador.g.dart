// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambassador.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AmbassadorReferralRequestDtoImpl _$$AmbassadorReferralRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AmbassadorReferralRequestDtoImpl(
  ambassadorAddress: json['ambassadorAddress'] as String,
);

Map<String, dynamic> _$$AmbassadorReferralRequestDtoImplToJson(
  _$AmbassadorReferralRequestDtoImpl instance,
) => <String, dynamic>{'ambassadorAddress': instance.ambassadorAddress};

_$AmbassadorStatsResponseDtoImpl _$$AmbassadorStatsResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AmbassadorStatsResponseDtoImpl(
  referralCount: (json['referralCount'] as num).toInt(),
);

Map<String, dynamic> _$$AmbassadorStatsResponseDtoImplToJson(
  _$AmbassadorStatsResponseDtoImpl instance,
) => <String, dynamic>{'referralCount': instance.referralCount};

_$AmbassadorVerificationResponseDtoImpl
_$$AmbassadorVerificationResponseDtoImplFromJson(Map<String, dynamic> json) =>
    _$AmbassadorVerificationResponseDtoImpl(
      isAmbassador: json['isAmbassador'] as bool,
      isReferral: json['isReferral'] as bool,
    );

Map<String, dynamic> _$$AmbassadorVerificationResponseDtoImplToJson(
  _$AmbassadorVerificationResponseDtoImpl instance,
) => <String, dynamic>{
  'isAmbassador': instance.isAmbassador,
  'isReferral': instance.isReferral,
};

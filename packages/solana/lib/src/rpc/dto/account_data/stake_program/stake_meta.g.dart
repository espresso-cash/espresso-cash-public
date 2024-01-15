// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeMeta _$StakeMetaFromJson(Map<String, dynamic> json) => StakeMeta(
      authorized:
          Authorized.fromJson(json['authorized'] as Map<String, dynamic>),
      lockup: Lockup.fromJson(json['lockup'] as Map<String, dynamic>),
      rentExemptReserve: json['rentExemptReserve'] as String,
    );

Map<String, dynamic> _$StakeMetaToJson(StakeMeta instance) => <String, dynamic>{
      'authorized': instance.authorized.toJson(),
      'lockup': instance.lockup.toJson(),
      'rentExemptReserve': instance.rentExemptReserve,
    };

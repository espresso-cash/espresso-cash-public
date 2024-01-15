// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_delegated_account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeDelegatedAccountInfo _$StakeDelegatedAccountInfoFromJson(
        Map<String, dynamic> json) =>
    StakeDelegatedAccountInfo(
      meta: StakeMeta.fromJson(json['meta'] as Map<String, dynamic>),
      stake: Stake.fromJson(json['stake'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StakeDelegatedAccountInfoToJson(
        StakeDelegatedAccountInfo instance) =>
    <String, dynamic>{
      'meta': instance.meta.toJson(),
      'stake': instance.stake.toJson(),
    };

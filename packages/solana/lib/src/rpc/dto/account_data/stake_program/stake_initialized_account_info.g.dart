// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_initialized_account_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeInitializedAccountInfo _$StakeInitializedAccountInfoFromJson(
        Map<String, dynamic> json) =>
    StakeInitializedAccountInfo(
      meta: StakeMeta.fromJson(json['meta'] as Map<String, dynamic>),
      stake: Stake.fromJson(json['stake'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StakeInitializedAccountInfoToJson(
        StakeInitializedAccountInfo instance) =>
    <String, dynamic>{
      'meta': instance.meta.toJson(),
      'stake': instance.stake.toJson(),
    };

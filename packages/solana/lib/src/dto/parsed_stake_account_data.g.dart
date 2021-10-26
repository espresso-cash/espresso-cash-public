// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_stake_account_data.dart';

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
      'meta': instance.meta,
      'stake': instance.stake,
    };

StakeMeta _$StakeMetaFromJson(Map<String, dynamic> json) => StakeMeta(
      authorized:
          Authorized.fromJson(json['authorized'] as Map<String, dynamic>),
      lockup: Lockup.fromJson(json['lockup'] as Map<String, dynamic>),
      rentExemptReserve: json['rentExemptReserve'] as String,
    );

Map<String, dynamic> _$StakeMetaToJson(StakeMeta instance) => <String, dynamic>{
      'authorized': instance.authorized,
      'lockup': instance.lockup,
      'rentExemptReserve': instance.rentExemptReserve,
    };

Authorized _$AuthorizedFromJson(Map<String, dynamic> json) => Authorized(
      staker: json['staker'] as String,
      withdrawer: json['withdrawer'] as String,
    );

Map<String, dynamic> _$AuthorizedToJson(Authorized instance) =>
    <String, dynamic>{
      'staker': instance.staker,
      'withdrawer': instance.withdrawer,
    };

Lockup _$LockupFromJson(Map<String, dynamic> json) => Lockup(
      custodian: json['custodian'] as String,
      epoch: json['epoch'] as int,
      unixTimestamp: json['unixTimestamp'] as int,
    );

Map<String, dynamic> _$LockupToJson(Lockup instance) => <String, dynamic>{
      'custodian': instance.custodian,
      'epoch': instance.epoch,
      'unixTimestamp': instance.unixTimestamp,
    };

Delegation _$DelegationFromJson(Map<String, dynamic> json) => Delegation(
      activationEpoch: json['activationEpoch'] as String,
      deactivationEpoch: json['deactivationEpoch'] as String,
      stake: json['stake'] as String,
      voter: json['voter'] as String,
      warmupCooldownRate: (json['warmupCooldownRate'] as num).toDouble(),
    );

Map<String, dynamic> _$DelegationToJson(Delegation instance) =>
    <String, dynamic>{
      'activationEpoch': instance.activationEpoch,
      'deactivationEpoch': instance.deactivationEpoch,
      'stake': instance.stake,
      'voter': instance.voter,
      'warmupCooldownRate': instance.warmupCooldownRate,
    };

Stake _$StakeFromJson(Map<String, dynamic> json) => Stake(
      delegation:
          Delegation.fromJson(json['delegation'] as Map<String, dynamic>),
      creditsObserved: json['creditsObserved'] as int,
    );

Map<String, dynamic> _$StakeToJson(Stake instance) => <String, dynamic>{
      'delegation': instance.delegation,
      'creditsObserved': instance.creditsObserved,
    };

_$StakeDelegatedAccountData _$$StakeDelegatedAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$StakeDelegatedAccountData(
      info: StakeDelegatedAccountInfo.fromJson(
          json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StakeDelegatedAccountDataToJson(
        _$StakeDelegatedAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

_$StakeUnknownAccountData _$$StakeUnknownAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$StakeUnknownAccountData(
      json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$StakeUnknownAccountDataToJson(
        _$StakeUnknownAccountData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

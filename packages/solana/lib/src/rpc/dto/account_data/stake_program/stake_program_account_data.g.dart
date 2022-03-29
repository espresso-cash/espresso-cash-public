// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_program_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StakeProgramDelegatedAccountData _$$StakeProgramDelegatedAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$StakeProgramDelegatedAccountData(
      info: StakeDelegatedAccountInfo.fromJson(
          json['info'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$StakeProgramDelegatedAccountDataToJson(
        _$StakeProgramDelegatedAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.$type,
    };

_$StakeProgramInitializedAccountData
    _$$StakeProgramInitializedAccountDataFromJson(Map<String, dynamic> json) =>
        _$StakeProgramInitializedAccountData(
          info: StakeInitializedAccountInfo.fromJson(
              json['info'] as Map<String, dynamic>),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$StakeProgramInitializedAccountDataToJson(
        _$StakeProgramInitializedAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.$type,
    };

_$StakeProgramUnknownAccountData _$$StakeProgramUnknownAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$StakeProgramUnknownAccountData(
      json['info'] as Map<String, dynamic>,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$$StakeProgramUnknownAccountDataToJson(
        _$StakeProgramUnknownAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.$type,
    };

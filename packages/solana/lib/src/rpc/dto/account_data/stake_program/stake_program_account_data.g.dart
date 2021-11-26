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
    );

Map<String, dynamic> _$$StakeProgramDelegatedAccountDataToJson(
        _$StakeProgramDelegatedAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

_$StakeProgramUnknownAccountData _$$StakeProgramUnknownAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$StakeProgramUnknownAccountData(
      json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$StakeProgramUnknownAccountDataToJson(
        _$StakeProgramUnknownAccountData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

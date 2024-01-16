// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_program_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StakeProgramDelegatedAccountDataImpl
    _$$StakeProgramDelegatedAccountDataImplFromJson(
            Map<String, dynamic> json) =>
        _$StakeProgramDelegatedAccountDataImpl(
          info: StakeDelegatedAccountInfo.fromJson(
              json['info'] as Map<String, dynamic>),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$StakeProgramDelegatedAccountDataImplToJson(
        _$StakeProgramDelegatedAccountDataImpl instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.$type,
    };

_$StakeProgramInitializedAccountDataImpl
    _$$StakeProgramInitializedAccountDataImplFromJson(
            Map<String, dynamic> json) =>
        _$StakeProgramInitializedAccountDataImpl(
          info: StakeInitializedAccountInfo.fromJson(
              json['info'] as Map<String, dynamic>),
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$StakeProgramInitializedAccountDataImplToJson(
        _$StakeProgramInitializedAccountDataImpl instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.$type,
    };

_$StakeProgramUnknownAccountDataImpl
    _$$StakeProgramUnknownAccountDataImplFromJson(Map<String, dynamic> json) =>
        _$StakeProgramUnknownAccountDataImpl(
          json['info'] as Map<String, dynamic>,
          $type: json['type'] as String?,
        );

Map<String, dynamic> _$$StakeProgramUnknownAccountDataImplToJson(
        _$StakeProgramUnknownAccountDataImpl instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.$type,
    };

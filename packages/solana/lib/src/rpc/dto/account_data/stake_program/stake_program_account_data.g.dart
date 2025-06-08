// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stake_program_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StakeProgramDelegatedAccountData _$StakeProgramDelegatedAccountDataFromJson(
  Map<String, dynamic> json,
) => StakeProgramDelegatedAccountData(
  info: StakeDelegatedAccountInfo.fromJson(json['info'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$StakeProgramDelegatedAccountDataToJson(
  StakeProgramDelegatedAccountData instance,
) => <String, dynamic>{'info': instance.info.toJson(), 'type': instance.$type};

StakeProgramInitializedAccountData _$StakeProgramInitializedAccountDataFromJson(
  Map<String, dynamic> json,
) => StakeProgramInitializedAccountData(
  info: StakeInitializedAccountInfo.fromJson(json['info'] as Map<String, dynamic>),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$StakeProgramInitializedAccountDataToJson(
  StakeProgramInitializedAccountData instance,
) => <String, dynamic>{'info': instance.info.toJson(), 'type': instance.$type};

StakeProgramUnknownAccountData _$StakeProgramUnknownAccountDataFromJson(
  Map<String, dynamic> json,
) => StakeProgramUnknownAccountData(
  json['info'] as Map<String, dynamic>,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$StakeProgramUnknownAccountDataToJson(
  StakeProgramUnknownAccountData instance,
) => <String, dynamic>{'info': instance.info, 'type': instance.$type};

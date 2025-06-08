// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedSplTokenProgramAccountData _$ParsedSplTokenProgramAccountDataFromJson(
  Map<String, dynamic> json,
) => ParsedSplTokenProgramAccountData(
  SplTokenProgramAccountData.fromJson(json['parsed'] as Map<String, dynamic>),
  $type: json['program'] as String?,
);

Map<String, dynamic> _$ParsedSplTokenProgramAccountDataToJson(
  ParsedSplTokenProgramAccountData instance,
) => <String, dynamic>{'parsed': instance.parsed.toJson(), 'program': instance.$type};

ParsedSplToken2022ProgramAccountData _$ParsedSplToken2022ProgramAccountDataFromJson(
  Map<String, dynamic> json,
) => ParsedSplToken2022ProgramAccountData(
  SplTokenProgramAccountData.fromJson(json['parsed'] as Map<String, dynamic>),
  $type: json['program'] as String?,
);

Map<String, dynamic> _$ParsedSplToken2022ProgramAccountDataToJson(
  ParsedSplToken2022ProgramAccountData instance,
) => <String, dynamic>{'parsed': instance.parsed.toJson(), 'program': instance.$type};

ParsedStakeProgramAccountData _$ParsedStakeProgramAccountDataFromJson(Map<String, dynamic> json) =>
    ParsedStakeProgramAccountData(
      StakeProgramAccountData.fromJson(json['parsed'] as Map<String, dynamic>),
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$ParsedStakeProgramAccountDataToJson(
  ParsedStakeProgramAccountData instance,
) => <String, dynamic>{'parsed': instance.parsed.toJson(), 'program': instance.$type};

UnsupportedProgramAccountData _$UnsupportedProgramAccountDataFromJson(Map<String, dynamic> json) =>
    UnsupportedProgramAccountData(
      json['parsed'] as Map<String, dynamic>,
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$UnsupportedProgramAccountDataToJson(
  UnsupportedProgramAccountData instance,
) => <String, dynamic>{'parsed': instance.parsed, 'program': instance.$type};

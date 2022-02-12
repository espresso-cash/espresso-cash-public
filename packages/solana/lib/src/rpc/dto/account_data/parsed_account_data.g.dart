// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedSplTokenProgramAccountData _$$ParsedSplTokenProgramAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$ParsedSplTokenProgramAccountData(
      SplTokenProgramAccountData.fromJson(
          json['parsed'] as Map<String, dynamic>),
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$$ParsedSplTokenProgramAccountDataToJson(
        _$ParsedSplTokenProgramAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
      'program': instance.$type,
    };

_$ParsedStakeProgramAccountData _$$ParsedStakeProgramAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$ParsedStakeProgramAccountData(
      StakeProgramAccountData.fromJson(json['parsed'] as Map<String, dynamic>),
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$$ParsedStakeProgramAccountDataToJson(
        _$ParsedStakeProgramAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
      'program': instance.$type,
    };

_$UnsupportedProgramAccountData _$$UnsupportedProgramAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$UnsupportedProgramAccountData(
      json['parsed'] as Map<String, dynamic>,
      $type: json['program'] as String?,
    );

Map<String, dynamic> _$$UnsupportedProgramAccountDataToJson(
        _$UnsupportedProgramAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
      'program': instance.$type,
    };

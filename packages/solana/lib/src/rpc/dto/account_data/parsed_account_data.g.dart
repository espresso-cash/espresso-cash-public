// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedSplTokenProgramAccountDataImpl
    _$$ParsedSplTokenProgramAccountDataImplFromJson(
            Map<String, dynamic> json) =>
        _$ParsedSplTokenProgramAccountDataImpl(
          SplTokenProgramAccountData.fromJson(
              json['parsed'] as Map<String, dynamic>),
          $type: json['program'] as String?,
        );

Map<String, dynamic> _$$ParsedSplTokenProgramAccountDataImplToJson(
        _$ParsedSplTokenProgramAccountDataImpl instance) =>
    <String, dynamic>{
      'parsed': instance.parsed.toJson(),
      'program': instance.$type,
    };

_$ParsedSplToken2022ProgramAccountDataImpl
    _$$ParsedSplToken2022ProgramAccountDataImplFromJson(
            Map<String, dynamic> json) =>
        _$ParsedSplToken2022ProgramAccountDataImpl(
          SplTokenProgramAccountData.fromJson(
              json['parsed'] as Map<String, dynamic>),
          $type: json['program'] as String?,
        );

Map<String, dynamic> _$$ParsedSplToken2022ProgramAccountDataImplToJson(
        _$ParsedSplToken2022ProgramAccountDataImpl instance) =>
    <String, dynamic>{
      'parsed': instance.parsed.toJson(),
      'program': instance.$type,
    };

_$ParsedStakeProgramAccountDataImpl
    _$$ParsedStakeProgramAccountDataImplFromJson(Map<String, dynamic> json) =>
        _$ParsedStakeProgramAccountDataImpl(
          StakeProgramAccountData.fromJson(
              json['parsed'] as Map<String, dynamic>),
          $type: json['program'] as String?,
        );

Map<String, dynamic> _$$ParsedStakeProgramAccountDataImplToJson(
        _$ParsedStakeProgramAccountDataImpl instance) =>
    <String, dynamic>{
      'parsed': instance.parsed.toJson(),
      'program': instance.$type,
    };

_$UnsupportedProgramAccountDataImpl
    _$$UnsupportedProgramAccountDataImplFromJson(Map<String, dynamic> json) =>
        _$UnsupportedProgramAccountDataImpl(
          json['parsed'] as Map<String, dynamic>,
          $type: json['program'] as String?,
        );

Map<String, dynamic> _$$UnsupportedProgramAccountDataImplToJson(
        _$UnsupportedProgramAccountDataImpl instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
      'program': instance.$type,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SplTokenProgramAccountData _$$SplTokenProgramAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$SplTokenProgramAccountData(
      ParsedSplTokenProgramAccountData.fromJson(
          json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SplTokenProgramAccountDataToJson(
        _$SplTokenProgramAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

_$StakeProgramAccountData _$$StakeProgramAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$StakeProgramAccountData(
      ParsedStakeAccountData.fromJson(json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StakeProgramAccountDataToJson(
        _$StakeProgramAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

_$UnsupportedProgramAccountData _$$UnsupportedProgramAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$UnsupportedProgramAccountData(
      json['parsed'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$UnsupportedProgramAccountDataToJson(
        _$UnsupportedProgramAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

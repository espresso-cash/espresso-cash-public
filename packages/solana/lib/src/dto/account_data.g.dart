// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BinaryAccountData _$$BinaryAccountDataFromJson(Map<String, dynamic> json) =>
    _$BinaryAccountData(
      (json['bytes'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$$BinaryAccountDataToJson(_$BinaryAccountData instance) =>
    <String, dynamic>{
      'bytes': instance.bytes,
    };

_$StringAccountData _$$StringAccountDataFromJson(Map<String, dynamic> json) =>
    _$StringAccountData(
      json['string'] as String,
    );

Map<String, dynamic> _$$StringAccountDataToJson(_$StringAccountData instance) =>
    <String, dynamic>{
      'string': instance.string,
    };

_$EmptyAccountData _$$EmptyAccountDataFromJson(Map<String, dynamic> json) =>
    _$EmptyAccountData();

Map<String, dynamic> _$$EmptyAccountDataToJson(_$EmptyAccountData instance) =>
    <String, dynamic>{};

_$SplTokenAccountData _$$SplTokenAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$SplTokenAccountData(
      ParsedSplTokenAccountData.fromJson(
          json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SplTokenAccountDataToJson(
        _$SplTokenAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

_$GenericAccountData _$$GenericAccountDataFromJson(Map<String, dynamic> json) =>
    _$GenericAccountData(
      json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$GenericAccountDataToJson(
        _$GenericAccountData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

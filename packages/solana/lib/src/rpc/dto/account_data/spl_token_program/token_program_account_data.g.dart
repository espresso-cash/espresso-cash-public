// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_program_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenAccountDataImpl _$$TokenAccountDataImplFromJson(
        Map<String, dynamic> json) =>
    _$TokenAccountDataImpl(
      info: SplTokenAccountDataInfo.fromJson(
          json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$$TokenAccountDataImplToJson(
        _$TokenAccountDataImpl instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.type,
      'accountType': instance.accountType,
    };

_$MintAccountDataImpl _$$MintAccountDataImplFromJson(
        Map<String, dynamic> json) =>
    _$MintAccountDataImpl(
      info: MintAccountDataInfo.fromJson(json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$$MintAccountDataImplToJson(
        _$MintAccountDataImpl instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.type,
      'accountType': instance.accountType,
    };

_$UnknownAccountDataImpl _$$UnknownAccountDataImplFromJson(
        Map<String, dynamic> json) =>
    _$UnknownAccountDataImpl(
      type: json['type'] as String,
    );

Map<String, dynamic> _$$UnknownAccountDataImplToJson(
        _$UnknownAccountDataImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

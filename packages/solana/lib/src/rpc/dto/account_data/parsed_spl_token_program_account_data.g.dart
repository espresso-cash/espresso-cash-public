// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_program_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokenAccountData _$$TokenAccountDataFromJson(Map<String, dynamic> json) =>
    _$TokenAccountData(
      info: ParsedSplTokenAccountDataInfo.fromJson(
          json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$$TokenAccountDataToJson(_$TokenAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
      'accountType': instance.accountType,
    };

_$MintAccountData _$$MintAccountDataFromJson(Map<String, dynamic> json) =>
    _$MintAccountData(
      info: ParsedSplMintAccountDataInfo.fromJson(
          json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$$MintAccountDataToJson(_$MintAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
      'accountType': instance.accountType,
    };

_$UnknownAccountData _$$UnknownAccountDataFromJson(Map<String, dynamic> json) =>
    _$UnknownAccountData(
      type: json['type'] as String,
    );

Map<String, dynamic> _$$UnknownAccountDataToJson(
        _$UnknownAccountData instance) =>
    <String, dynamic>{
      'type': instance.type,
    };

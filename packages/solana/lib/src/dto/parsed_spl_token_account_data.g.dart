// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedSplTokenAccountData _$ParsedSplTokenAccountDataFromJson(
        Map<String, dynamic> json) =>
    ParsedSplTokenAccountData(
      info: ParsedSplTokenAccountDataInfo.fromJson(
          json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$ParsedSplTokenAccountDataToJson(
        ParsedSplTokenAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'type': instance.type,
      'accountType': instance.accountType,
    };

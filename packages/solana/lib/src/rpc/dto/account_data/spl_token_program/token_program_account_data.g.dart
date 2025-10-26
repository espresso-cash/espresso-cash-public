// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_program_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenAccountData _$TokenAccountDataFromJson(Map<String, dynamic> json) =>
    TokenAccountData(
      info: SplTokenAccountDataInfo.fromJson(
        json['info'] as Map<String, dynamic>,
      ),
      type: json['type'] as String,
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$TokenAccountDataToJson(TokenAccountData instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.type,
      'accountType': instance.accountType,
    };

MintAccountData _$MintAccountDataFromJson(Map<String, dynamic> json) =>
    MintAccountData(
      info: MintAccountDataInfo.fromJson(json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$MintAccountDataToJson(MintAccountData instance) =>
    <String, dynamic>{
      'info': instance.info.toJson(),
      'type': instance.type,
      'accountType': instance.accountType,
    };

UnknownAccountData _$UnknownAccountDataFromJson(Map<String, dynamic> json) =>
    UnknownAccountData(type: json['type'] as String);

Map<String, dynamic> _$UnknownAccountDataToJson(UnknownAccountData instance) =>
    <String, dynamic>{'type': instance.type};

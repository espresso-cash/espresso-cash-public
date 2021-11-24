// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_account_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ParsedMintAccountData _$$ParsedMintAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$ParsedMintAccountData(
      info: MintAccountDataInfo.fromJson(json['info'] as Map<String, dynamic>),
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$$ParsedMintAccountDataToJson(
        _$ParsedMintAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'accountType': instance.accountType,
    };

_$SplTokenAccountData _$$SplTokenAccountDataFromJson(
        Map<String, dynamic> json) =>
    _$SplTokenAccountData(
      info: SplTokenAccountDataInfo.fromJson(
          json['info'] as Map<String, dynamic>),
      accountType: json['accountType'] as String?,
    );

Map<String, dynamic> _$$SplTokenAccountDataToJson(
        _$SplTokenAccountData instance) =>
    <String, dynamic>{
      'info': instance.info,
      'accountType': instance.accountType,
    };

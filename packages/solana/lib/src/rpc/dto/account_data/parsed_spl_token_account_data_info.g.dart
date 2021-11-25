// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parsed_spl_token_account_data_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParsedSplTokenAccountDataInfo _$ParsedSplTokenAccountDataInfoFromJson(
        Map<String, dynamic> json) =>
    ParsedSplTokenAccountDataInfo(
      tokenAmount:
          TokenAmount.fromJson(json['tokenAmount'] as Map<String, dynamic>),
      state: json['state'] as String,
      isNative: json['isNative'] as bool,
      mint: json['mint'] as String,
      owner: json['owner'] as String,
      delegate: json['delegate'] as String?,
      delegateAmount: json['delegateAmount'] == null
          ? null
          : TokenAmount.fromJson(
              json['delegateAmount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParsedSplTokenAccountDataInfoToJson(
        ParsedSplTokenAccountDataInfo instance) =>
    <String, dynamic>{
      'tokenAmount': instance.tokenAmount,
      'state': instance.state,
      'isNative': instance.isNative,
      'mint': instance.mint,
      'owner': instance.owner,
      'delegate': instance.delegate,
      'delegateAmount': instance.delegateAmount,
    };

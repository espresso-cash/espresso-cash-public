// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      owner: json['owner'] as String,
      lamports: json['lamports'] as int,
      executable: json['executable'] as bool,
      rentEpoch: json['rentEpoch'] as int,
      data: json['data'] == null
          ? null
          : AccountData.fromJson(json['data'] as Map<String, dynamic>),
    );

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) =>
    AccountInfoResponse(
      ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
          (value) => Account.fromJson(value as Map<String, dynamic>)),
    );

ParsedSplTokenAccountData _$ParsedSplTokenAccountDataFromJson(
        Map<String, dynamic> json) =>
    ParsedSplTokenAccountData(
      accountType: json['accountType'] as String,
      info: ParsedSplTokenAccountDataInfo.fromJson(
          json['info'] as Map<String, dynamic>),
      type: json['type'] as String,
    );

Map<String, dynamic> _$ParsedSplTokenAccountDataToJson(
        ParsedSplTokenAccountData instance) =>
    <String, dynamic>{
      'accountType': instance.accountType,
      'info': instance.info,
      'type': instance.type,
    };

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
      parsed: ParsedSplTokenAccountData.fromJson(
          json['parsed'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SplTokenAccountDataToJson(
        _$SplTokenAccountData instance) =>
    <String, dynamic>{
      'parsed': instance.parsed,
    };

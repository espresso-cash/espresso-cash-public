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
          ? const AccountData.empty()
          : AccountData.fromJson(json['data']),
    );

AccountInfoResponse _$AccountInfoResponseFromJson(Map<String, dynamic> json) =>
    AccountInfoResponse(
      ValueResponse.fromJson(json['result'] as Map<String, dynamic>,
          (value) => Account.fromJson(value as Map<String, dynamic>)),
    );

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
      data: const AccountDataConverter().fromJson(json['data']),
    );

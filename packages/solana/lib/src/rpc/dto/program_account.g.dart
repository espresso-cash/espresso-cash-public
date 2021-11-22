// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramAccount _$ProgramAccountFromJson(Map<String, dynamic> json) =>
    ProgramAccount(
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
      pubkey: json['pubkey'] as String,
    );

Map<String, dynamic> _$ProgramAccountToJson(ProgramAccount instance) =>
    <String, dynamic>{
      'account': instance.account,
      'pubkey': instance.pubkey,
    };

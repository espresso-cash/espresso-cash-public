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
      'account': instance.account.toJson(),
      'pubkey': instance.pubkey,
    };

ProgramAccountsResult _$ProgramAccountsResultFromJson(
        Map<String, dynamic> json) =>
    ProgramAccountsResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: (json['value'] as List<dynamic>)
          .map((e) => ProgramAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgramAccountsResultToJson(
        ProgramAccountsResult instance) =>
    <String, dynamic>{
      'context': instance.context.toJson(),
      'value': instance.value.map((e) => e.toJson()).toList(),
    };

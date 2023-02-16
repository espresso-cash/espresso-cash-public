// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'large_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LargeAccount _$LargeAccountFromJson(Map<String, dynamic> json) => LargeAccount(
      address: json['address'] as String,
      lamports: json['lamports'] as int,
    );

LargeAccountsResult _$LargeAccountsResultFromJson(Map<String, dynamic> json) =>
    LargeAccountsResult(
      context: Context.fromJson(json['context'] as Map<String, dynamic>),
      value: (json['value'] as List<dynamic>)
          .map((e) => LargeAccount.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

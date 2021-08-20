// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'associated_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociatedTokenAccount _$AssociatedTokenAccountFromJson(
        Map<String, dynamic> json) =>
    AssociatedTokenAccount(
      address: json['pubkey'] as String,
      account: Account.fromJson(json['account'] as Map<String, dynamic>),
    );

AssociatedTokenAccountResponse _$AssociatedTokenAccountResponseFromJson(
        Map<String, dynamic> json) =>
    AssociatedTokenAccountResponse(
      ValueResponse.fromJson(
          json['result'] as Map<String, dynamic>,
          (value) => (value as List<dynamic>)
              .map((e) =>
                  AssociatedTokenAccount.fromJson(e as Map<String, dynamic>))
              .toList()),
    );

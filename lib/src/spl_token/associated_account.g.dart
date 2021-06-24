// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'associated_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssociatedAccount _$AssociatedAccountFromJson(Map<String, dynamic> json) {
  return AssociatedAccount(
    address: json['pubkey'] as String,
    account: Account.fromJson(json['account'] as Map<String, dynamic>),
  );
}

AssociatedAccountResponse _$AssociatedAccountResponseFromJson(
    Map<String, dynamic> json) {
  return AssociatedAccountResponse(
    ValueResponse.fromJson(
        json['result'] as Map<String, dynamic>,
        (value) => (value as List<dynamic>)
            .map((e) => AssociatedAccount.fromJson(e as Map<String, dynamic>))
            .toList()),
  );
}

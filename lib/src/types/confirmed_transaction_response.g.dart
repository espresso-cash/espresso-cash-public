// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmed_transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmedTransactionResponse _$ConfirmedTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return ConfirmedTransactionResponse(
    json['result'] == null
        ? null
        : GetTransactionResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

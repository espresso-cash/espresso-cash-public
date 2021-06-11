// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_transaction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTransactionResult _$GetTransactionResultFromJson(Map<String, dynamic> json) {
  return GetTransactionResult(
    meta: json['meta'] == null
        ? null
        : Meta.fromJson(json['meta'] as Map<String, dynamic>),
    slot: json['slot'] as int,
    blockTime: json['blockTime'] as int,
    transaction:
        Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
  );
}

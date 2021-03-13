// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) {
  return TransactionResponse(
    meta: json['meta'] == null
        ? null
        : TxMeta.fromJson(json['meta'] as Map<String, dynamic>),
    slot: json['slot'] as int,
    blockTime: json['blockTime'] as int,
    instructions: (json['instructions'] as List)?.map((e) =>
        e == null ? null : TxInstruction.fromJson(e as Map<String, dynamic>)),
  );
}

TransferTx _$TransferTxFromJson(Map<String, dynamic> json) {
  return TransferTx(
    source: json['source'] as String,
    destination: json['destination'] as String,
    lamports: json['lamports'] as int,
  );
}

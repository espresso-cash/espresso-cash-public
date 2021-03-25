// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmedTransactionResponse _$ConfirmedTransactionResponseFromJson(
    Map<String, dynamic> json) {
  return ConfirmedTransactionResponse(
    json['result'] == null
        ? null
        : ConfirmedTransaction.fromJson(json['result'] as Map<String, dynamic>),
  );
}

ConfirmedTransaction _$ConfirmedTransactionFromJson(Map<String, dynamic> json) {
  return ConfirmedTransaction(
    meta: json['meta'] == null
        ? null
        : TxMeta.fromJson(json['meta'] as Map<String, dynamic>),
    slot: json['slot'] as int,
    blockTime: json['blockTime'] as int,
    transaction:
        Transaction.fromJson(json['transaction'] as Map<String, dynamic>),
  );
}

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return Transaction(
    message: TxMessage.fromJson(json['message'] as Map<String, dynamic>),
  );
}

TxMessage _$TxMessageFromJson(Map<String, dynamic> json) {
  return TxMessage(
    instructions: (json['instructions'] as List<dynamic>?)
        ?.map((e) => TxInstruction.fromJson(e as Map<String, dynamic>)),
  );
}

TransferTx _$TransferTxFromJson(Map<String, dynamic> json) {
  return TransferTx(
    source: json['source'] as String,
    destination: json['destination'] as String,
    lamports: json['lamports'] as int,
  );
}
